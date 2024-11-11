
module ALU (
    input [31:0] scrA, 
    input [31:0] scrB,
    input [2:0] AluControl, //Verily will the ALU only need to add
    output reg [31:0] ALUresult, 
    output reg [1:0]Flag    //Zero, Carry, Overflow, Sign
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
    ADD:  ALUresult = scrA + scrB;
    SUB:  ALUresult = scrA - scrB;
    ANDD: ALUresult = scrA & scrB;
    LSHIFT: ALUresult = scrA << scrB;
    CMP: Flag[CMP_flag] = ((scrA ^ scrB) == {32{1'b0}}) ? 1'b1 : 1'b0;     //si son iguales el xor deberia resultar en 0. 
    default: ALUresult = 0;
    endcase

    if (ALUresult == 0) Flag[ZERO] = 1;   //source of error, as a and could leave me with a zero, or a default.
    if (ALUresult < 0)  Flag[SIGN] = 1;   

end
    
endmodule









