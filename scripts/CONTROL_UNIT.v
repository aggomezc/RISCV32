`include "MAIN_DECODER.v"
`include "ALU_DECODE.v"
`include "/home/carnifex/Desktop/S VI/Microprocesors/Proyect/RISCV_CPU/scripts/BranchEncoder.v"
module Control_Unit (
    input [2:0] funct3,
    input [6:0] opcode,
    input [1:0] ALU_flags,

    output  RegWrite,
    output [2:0]  ImmSrc,
    output ALU_src,
    output MemWrite,
    output [1:0] Result_src,
    output PC_Src,
    output [2:0] ALU_Control,
    output WriteRegisterData_Src
);
    parameter   ZERO = 0,
                SIGN = 1;
 

    wire [2:0] ALU_op;
    wire Branch;
    wire Jump;
    wire PC_Src;
    wire EncodedBranch;
    wire WriteRegisterData_Src_Intermediate;
    wire  RegWrite_intermediate;
    wire [2:0]  ImmSrc_intermediate;
    wire ALU_src_intermediate;
    wire MemWrite_intermediate;
    wire [1:0] Result_src_intermediate;
    wire [2:0] ALU_Control_intermediate;

    assign RegWrite = RegWrite_intermediate;
    assign ImmSrc = ImmSrc_intermediate;
    assign ALU_src = ALU_src_intermediate;
    assign MemWrite = MemWrite_intermediate;
    assign Result_src = Result_src_intermediate;
    assign ALU_Control = ALU_Control_intermediate;
    assign WriteRegisterData_Src = WriteRegisterData_Src_Intermediate;

    
    assign PC_Src = (~EncodedBranch & Branch & ALU_flags[ZERO]) |
    (~EncodedBranch & Branch & ~ALU_flags[SIGN]) |
    (EncodedBranch & Branch & ~ALU_flags[ZERO]) |
    Jump;
    

    
                    
    Main_Decoder main_decoder (
        .opcode(opcode),
        .funct3(funct3),
        .RegWrite(RegWrite_intermediate),
        .ImmSrc(ImmSrc_intermediate),
        .ALU_src(ALU_src_intermediate),
        .MemWrite(MemWrite_intermediate),
        .Result_src(Result_src_intermediate),
        .Branch(Branch),
        .ALU_op(ALU_op),
        .Jump(Jump),
        .WriteRegisterData_Src(WriteRegisterData_Src_Intermediate)
    );
    ALU_DECODE Alu_decode(
        .ALUOP(ALU_op),
        .funct3(funct3),
        .ALU_Control(ALU_Control_intermediate)
    );
    BranchEncoder BranchEncoding(
        .funct3(funct3),
        .Encoded_Branch(EncodedBranch)
    );
endmodule