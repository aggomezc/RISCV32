
module ALU (
    input [31:0] scrA, 
    input [31:0] scrB,
    input [2:0] AluControl, //Verily will the ALU only need to add
    output reg signed [31:0] ALUresult, 
    output reg [1:0]Flag    //None, Sign, Zero
);
parameter ADD = 0;
parameter SUB = 1;
parameter ANDD = 2;
parameter LSHIFT = 3; 

parameter   ZERO = 0,
            SIGN = 1;

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
    end
    
    ANDD: begin
        ALUresult = scrA & scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
    end

    LSHIFT: begin
        ALUresult = scrA << scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;

    end

    default: begin
        ALUresult = 0;
        Flag[ZERO] =0;
        Flag[SIGN] =0;
    end 
    endcase

end
    
endmodule









