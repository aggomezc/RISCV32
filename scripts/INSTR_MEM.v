//`timescale 1ns / 1ps

module MEM (
    input [31:0] PC,
    output reg [31:0] Instr
);
reg [31:0] mem_arr[29:0];

initial begin
    $readmemh("INSTRS/HEX_FILE_CORRECTO.hexw", mem_arr);
end
always @(*) begin
    Instr = mem_arr[PC];
end


endmodule