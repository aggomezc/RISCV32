module BranchEncoder (
    input [2:0] funct3,

    output reg Encoded_Branch
);
    parameter BGE = 3'b101;
    parameter BNE = 3'b001;

    always @(*) begin 
            case (funct3)
            BGE: Encoded_Branch = 0;
            BNE: Encoded_Branch = 1;  
            default: Encoded_Branch = 1'bx;
            endcase

    end
endmodule
