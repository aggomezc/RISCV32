`include "MAIN_DECODER.v"
`include "ALU_DECODE.v"

module Control_Unit (
    input [2:0] funct3,
    input [6:0] opcode,
    input [2:0] ALU_flags,

    output  RegWrite,
    output [1:0]  ImmSrc,
    output ALU_src,
    output MemWrite,
    output Result_src,
    output PC_Src,
    output [2:0] ALU_Control

);
    parameter   ZERO = 0,
                SIGN = 1,
            CMP_flag = 2;

    wire [2:0] ALU_op;
    wire Branch;
    wire Jump;
    wire PC_Src;

    assign PC_Src = (ALU_flags[ZERO] & Branch) + 
                    (~ALU_flags[SIGN] & Branch) + 
                    (ALU_flags[CMP_flag] & Branch) + 
                    Jump;
    
    Main_Decoder main_decoder (
        .opcode(opcode),
        .funct3(funct3),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALU_src(ALU_src),
        .MemWrite(MemWrite),
        .Result_src(Result_src),
        .Branch(Branch),
        .ALU_op(ALU_op),
        .Jump(Jump)
    );
    ALU_DECODE Alu_decode(
        .ALUOP(ALU_op),
        .funct3(funct3),
        .ALU_Control(ALU_Control)
    );
endmodule