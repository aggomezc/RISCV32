module PC_ADDER(
    input  clk,
    input  rst,
    output reg [31:0] pc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 0;
    end else begin
        pc <= pc + 4;
    end
end

endmodule
