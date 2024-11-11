module Control_Unit (
    input [2:0] funct3,
          [6:0] opcode,

    output reg RegWrite,
    output [1:0] reg ImmSrc,
    output reg ALU_src,
    output reg MemWrite,
    output reg Result_src,
    output reg Branch,
    output reg [2:0] ALU_op,
    output reg Jump
);
    
endmodule