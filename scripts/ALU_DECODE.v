module ALU_DECODE (
    input [2:0] ALUOP,
    input [2:0] funct3,

    output reg [2:0] ALU_Control
);
  parameter SPECIAL = 3'b111,
            ADD = 3'b000,
            SUB = 3'b001,
            COMPARE = 3'b100,
            LEFT_SHIFT = 3'b011,
            ANDD = 3'b010

    always @(ALUOP) begin
        case (ALUOP)
            SPECIAL begin
                if (funct3 == ADD) begin    //funct3 removed
                    ALU_Control = ADD;
                end    

                if (funct3 == 1) begin
                    ALU_Control = LEFT_SHIFT;
                end
                
                if (funct3 == 8) begin
                    ALU_Control = ANDD;
                end
            end 

            3'b000 begin
                ALU_Control = ADD;
            end
            3'b100: ALU_Control = COMPARE;
            3'b001: ALU_Control = SUB; 

            default: ALU_Control = ADD;
        endcase

    end
endmodule