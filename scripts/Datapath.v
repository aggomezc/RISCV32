`include "ALU.v"
`include "CONTROL_UNIT.v"
`include "DYNAMIC_MEM.v"
`include "Extender.v"
`include "INSTR_MEM.v"
`include "MUX2.v"
`include "MUX3.v"
`include "REGISTER_FILE.v"
`include "D_flip_flop.v"
`include "PC_ADDER.v"
`include "PC_BRANCH_ADDER.v"

module Datapath (
    input CLK,
    input Reset    
);
//wires que conectan componentes datapath
//se limitan a transmitir datos de algun tipo
reg [31:0] PC;
wire [31:0] PCnext;
wire [31:0] PC_wire;
wire [31:0] Instruction;
wire [31:0] Extended_Imm;
wire [31:0] SrcA_wire;
wire [31:0] Reg2_output;
wire [31:0] SrcB_wire;
wire [31:0] ALUResult_wire;
wire [2:0] ALU_Flags;
wire [31:0] PC_plus_4;
wire [31:0] PCTarget;
wire [31:0] Result_wire;
wire [31:0] Read_Mem_Data;
//wire que llevan las unidades de control 
wire PCSrc;
wire [1:0] Result_Src
wire MemWrite_Enable;
wire [2:0] ALU_CONTROL_wire;
wire ALU_Src;
wire [1:0] Imm_src;
wire RegWrite_EN;


initial begin
    PC = 32'b0;
end

MEM Instruction_Memory(
    .PC(PC),
    .Instr(Instruction)
);
REGISTERFILE Register_File(
    .CLK(CLK),
    .A1(Instruction[19:15]), //dir reg 1
    .A2(Instruction[24:20]), //dir reg 2
    .A3(Instruction[11:7]), ////dir reg to write
    .WD3(Result_wire), //write data
    .RD1(SrcA_wire), // data read from reg 1
    .RD2(Reg2_output), // data read from reg 2
    .EN(RegWrite_EN)  //// ENABLE read
    );
ALU ALU_unit((
    .scrA(SrcA_wire), 
    .scrB(SrcB_wire),
    .AluControl(ALU_CONTROL_wire), //Verily will the ALU only need to add
    .ALUresult(ALUResult_wire), 
    .Flag(ALU_Flags) 
);
DynamicMemory DataMemory(
    .CLK(CLK),
    .WE(MemWrite_Enable),
    .funct3(Instruction[14:12]),
    .ADDRESS(ALUResult_wire),
    .WRITE_DATA(Reg2_output),  
    .READ_DATA(Read_Mem_Data)
);

EXTENSION Imm_Extender(
    .Instr(Instruction), //podria ser menor Later change
    .ImmControl(Imm_src),
    .ExtendedImm(Extended_Imm)
);



endmodule