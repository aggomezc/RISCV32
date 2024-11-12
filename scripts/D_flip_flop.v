module d_flip_flop(
    input  clk,
    input [31:0]  d,
    input  rst,
    output reg [31:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 40;
    end else begin
        q <= d;
    end
end

endmodule
