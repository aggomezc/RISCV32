//`timescale 1ns / 1ps

module MEM (
    input CLK,
    input [31:0] PC,
    output reg [31:0] Instr
);
reg [31:0] mem_arr[29:0];

initial begin
    $readmemh("INSTRS/HEX_FILE_CORRECTO.hexw", mem_arr);
    Instr = 31'hFFFFFFFF;
end
always @(posedge CLK ) begin
    Instr <= mem_arr[PC];
end


endmodule