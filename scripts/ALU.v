
module ALU (
    input [31:0] scrA, 
    input [31:0] scrB,
    input [2:0] AluControl, //Verily will the ALU only need to add
    output reg [31:0] ALUresult, 
    output reg [2:0]Flag    //Zero, Carry, Overflow, Sign
);
parameter ADD = 0;
parameter SUB = 1;
parameter ANDD = 2;
parameter LSHIFT = 3; 
parameter CMP = 4;

parameter   ZERO = 0,
            SIGN = 1,
            CMP_flag = 2;
//and 1
//lshift 2
always @(*) begin
    case (AluControl)
    ADD:  begin 
        ALUresult = scrA + scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
    end 

    SUB:  begin
        ALUresult = scrA - scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
        Flag[CMP_flag] = 0;
    end
    
    ANDD: begin
        ALUresult = scrA & scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
        Flag[CMP_flag] = 0;
    end

    LSHIFT: begin
        ALUresult = scrA << scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
        Flag[CMP_flag] = 0;

    end
    
    CMP: begin
        ALUresult = (scrA ^ scrB);
        Flag[CMP_flag] = ((scrA ^ scrB) == {32{1'b0}}) ? 1'b1 : 1'b0;     //si son iguales el xor deberia resultar en 0. 
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
    end
    default: begin
        ALUresult = 0;
        Flag[ZERO] =0;
        Flag[SIGN] =0;
        Flag[CMP_flag] = 0;
    end 
    endcase

end
    
endmodule









