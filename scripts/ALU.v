`timescale 1ns / 1ps


module ALU (
    input [31:0] scrA, 
    input [31:0] ScrB,
    input [2:0] AluControl, //Verily will the ALU only need to add
    output [31:0] ALUresult, 
    output [3:0]Flag    //Zero, Carry, Overflow, Sign
);
parameter ADD = 0;
parameter SUB = 1;
parameter ANDD = 2;
parameter LSHIFT = 3;

parameter   ZERO = 0,
            CARRY = 1,
            OVERFLOW = 2,
            SIGN = 3;
//and 1
//lshift 2
always @(*) begin
    case (AluControl)
    ADD:  ALUresult = scrA + scrB;
    SUB:  ALUresult = scrA - scrB;
    ANDD: ALUresult = scrA & ScrB;
    LSHIFT: ALUresult = scrA << ScrB;
    default: ALUresult = 0;
    endcase

    if (ALUresult == 0) Flag[ZERO] = 1;
    if ()

end
assign 
    
endmodule