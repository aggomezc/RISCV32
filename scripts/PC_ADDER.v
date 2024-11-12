module PC_ADDER(
    input [31:0] PC_itself,
    output [31:0] pc
);

    assign pc = PC_itself + 4;


endmodule
