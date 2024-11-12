module PC_BRANCH_ADDER(
    input  clk,
    input  rst,
    input  [31:0] branch_offset,
    output reg [31:0] pc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 0;
    end else begin
        pc <= pc + branch_offset;
    end
end

endmodule