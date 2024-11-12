module PC_BRANCH_ADDER(

    input [31:0] PC_itself,
    input  [31:0] branch_offset,
    output  [31:0] pc
);

    assign pc = PC_itself + branch_offset;


endmodule