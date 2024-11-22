 ///home/carnifex/Desktop/S VI/Microprocesors/Proyect/RISCV_CPU/scripts/
`include "MAIN_DECODER.v"
`include "ALU_DECODE.v"
`include "BranchEncoder.v"

//////////////////////////////////////////////////////////////
// Módulo: Control_Unit
// Funcionalidad:
// La unidad de control es responsable de generar todas las señales
// de control necesarias para coordinar las operaciones del procesador.
// Basándose en el opcode, funct3 y las banderas de la ALU, produce
// señales que determinan el flujo del programa y las operaciones a realizar.
//
// Entradas:
// - `funct3` [2:0]: Campo de función que especifica la operación.
// - `opcode` [6:0]: Código de operación que indica el tipo de instrucción.
// - `ALU_flags` [1:0]: Banderas de la ALU (ZERO y SIGN).
//
// Salidas:
// - `RegWrite`: Habilita la escritura en el banco de registros.
// - `ImmSrc` [2:0]: Selecciona el tipo de inmediato a utilizar.
// - `ALU_src`: Determina la fuente del segundo operando de la ALU.
// - `MemWrite`: Habilita la escritura en memoria.
// - `Result_src` [1:0]: Selecciona el origen del dato para escribir en el registro.
// - `PC_Src`: Controla la fuente de actualización del contador de programa (PC).
// - `ALU_Control` [2:0]: Señal de control específica para la ALU.
// - `WriteRegisterData_Src`: Selecciona la fuente de datos para escribir en el registro.
//
// Razón de introducción:
// Este módulo centraliza la lógica de control, permitiendo una gestión eficiente
// y organizada de las señales que dirigen el comportamiento del procesador.
// Facilita la expansión y mantenimiento del diseño al modularizar las funciones de control.
//////////////////////////////////////////////////////////////

module Control_Unit (
    input [2:0] funct3,
    input [6:0] opcode,
    input [1:0] ALU_flags,

    output RegWrite,
    output [2:0] ImmSrc,
    output ALU_src,
    output MemWrite,
    output [1:0] Result_src,
    output PC_Src,
    output [2:0] ALU_Control,
    output WriteRegisterData_Src
);
    // Parámetros para índices de banderas
    parameter ZERO = 0,
              SIGN = 1;

    // Declaración de señales internas
    wire [2:0] ALU_op;
    wire Branch;
    wire Jump;
    wire EncodedBranch;
    wire WriteRegisterData_Src_Intermediate;
    wire RegWrite_intermediate;
    wire [2:0] ImmSrc_intermediate;
    wire ALU_src_intermediate;
    wire MemWrite_intermediate;
    wire [1:0] Result_src_intermediate;
    wire [2:0] ALU_Control_intermediate;

    // Asignación de señales internas a las salidas correspondientes
    assign RegWrite = RegWrite_intermediate;
    assign ImmSrc = ImmSrc_intermediate;
    assign ALU_src = ALU_src_intermediate;
    assign MemWrite = MemWrite_intermediate;
    assign Result_src = Result_src_intermediate;
    assign ALU_Control = ALU_Control_intermediate;
    assign WriteRegisterData_Src = WriteRegisterData_Src_Intermediate;

    // Lógica para determinar la fuente del PC (contador de programa)
    assign PC_Src = 
        (~EncodedBranch & Branch & ALU_flags[ZERO])     | // BEQ: salto si cero
        (~EncodedBranch & Branch & ~ALU_flags[SIGN])    | // BGE: salto si mayor o igual
        (EncodedBranch & Branch & ~ALU_flags[ZERO])     | // BNE: salto si no es cero
        Jump;                                             // JAL: salto incondicional

    // Instanciación del decodificador principal
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

    // Instanciación del decodificador de la ALU
    ALU_DECODE Alu_decode (
        .ALUOP(ALU_op),
        .funct3(funct3),
        .ALU_Control(ALU_Control_intermediate)
    );

    // Instanciación del codificador de ramas
    BranchEncoder BranchEncoding (
        .funct3(funct3),
        .Encoded_Branch(EncodedBranch)
    );
endmodule
