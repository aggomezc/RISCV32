module Control_Unit (
    input [6:0] opcode,
    input [2:0] funct3,

    
    output reg RegWrite,
    output [1:0] reg ImmSrc,
    output reg ALU_src,
    output reg MemWrite,
    output reg Result_src,
    output reg Branch,
    output reg [2:0] ALU_op,
    output reg Jump,
    output reg [2:0] ALU_Control

);
    parameter  LOAD_W_B = 7'b0000011,
               STORE_W_B = 7'b0100011,
               R_TYPE = 7'b0110011,
               BRANCH = 7'b1100011,
               I_TYPE = 7'b0010011,
               JAL = 7'b1101111, //porque un Jump es un JAl con rd=0
               LUI = 7'b0110111
               parameter FUNCT3_BRANCH_GE = 3'b101,
              FUNCT3_BRANCH_NEQ = 3'b001;

    parameter SPECIAL = 3'b111,
               ADD = 3'b000,
               SUB = 3'b001,
               COMPARE = 3'b100,
               LEFT_SHIFT = 3'b011;


    always @(opcode or funct3) begin
        case (param)
            LOAD_W_B begin
                RegWrite = 1;
                ImmSrc =   2'b00;
                ALU_src =  1;
                MemWrite = 0;
                Result_src = 2'b01;
                Branch =  0 ;
                ALU_op = ADD;
                Jump = 0;
            end
            
            STORE_W_B begin
                RegWrite = 0;
                ImmSrc =   2'b01;
                ALU_src =  1;
                MemWrite = 1;
                Result_src = 2'bxx;
                Branch =  0 ;
                ALU_op = ADD;
                Jump = 0;
            end


            BRANCH begin
                RegWrite = 0;
                ImmSrc =   2'b10;
                ALU_src =  0;
                MemWrite = 0;
                Result_src = 2'bxx;
                Branch =  1 ;
                ALU_op =  (funct3 == 001) ? 3'b100 : 3'b001; //se elige el tipo de branch que se tiene que realizar
                Jump = 0;
            end

            I_TYPE begin
                RegWrite = 1;
                ImmSrc =   2'b00;
                ALU_src =  1;
                MemWrite = 0;
                Result_src = 2'b00;
                Branch =  0 ;
                ALU_op =   3'b111;
                Jump = 0;
            end

            JAL begin
                RegWrite = 1;
                ImmSrc =   2'b11;
                ALU_src =  1'bx;
                MemWrite = 0;
                Result_src = 2'b10;
                Branch =  0 ;
                ALU_op =   3'bxxx; //unconditional jump here
                Jump = 1;
            end


            LUI begin
                RegWrite = 1;
                ImmSrc =   2'b11;
                ALU_src =  1'bx;
                MemWrite = 0;
                Result_src = 2'bx;
                Branch =  0 ;
                ALU_op =   3'bxxx;
                Jump = 0;
            end
            
            default begin
                RegWrite = 1;
                ImmSrc =   2'b00;
                ALU_src =  1;
                MemWrite = ;0
                Result_src = 2'b01;
                Branch =  0 ;
                ALU_op = 3'b;
                Jump = 0;
            end
        endcase
    end
endmodule