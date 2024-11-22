`include "MAIN_DECODER.v" // Incluir el módulo MAIN_DECODER a testear

////////////////////////////////////////////////////////////
// Banco de Pruebas: TB_MainDecoder
// Objetivo de la prueba:
// Verificar que el módulo MAIN_DECODER genera correctamente
// las señales de control para diferentes tipos de instrucciones.

// Estímulos:
// - Aplicar diferentes valores de opcode y funct3 para cubrir
//   varios tipos de instrucciones:
//     - Instrucciones de carga (LOAD_W_B)
//     - Instrucciones de almacenamiento (STORE_W_B)
//     - Instrucciones de rama (BRANCH)
//     - Instrucciones tipo I (I_TYPE)
//     - Instrucciones de salto (JAL)
//     - Instrucciones LUI (Load Upper Immediate)
//     - Instrucción por defecto (DEFAULT)

// Descripción de resultados esperados:
// - Cada señal de salida debe reflejar correctamente las señales
//   de control necesarias para la instrucción dada.
// - Se indicarán los valores esperados de las señales para cada prueba.
////////////////////////////////////////////////////////////

module TB_MainDecoder;
    // Declaración de señales de prueba
    reg [6:0] opcode;           // Entrada: opcode que define el tipo de instrucción
    reg [2:0] funct3;           // Entrada: campo funct3 que detalla la operación
    wire RegWrite;              // Salida: indica si se escribe en un registro
    wire [2:0] ImmSrc;          // Salida: determina el tipo de inmediato a generar
    wire ALU_src;               // Salida: selecciona entre operando o inmediato para la ALU
    wire MemWrite;              // Salida: indica si se realiza escritura en memoria
    wire [1:0] Result_src;      // Salida: selecciona la fuente del resultado
    wire Branch;                // Salida: indica si la instrucción es un branch
    wire [2:0] ALU_op;          // Salida: operación que realizará la ALU
    wire Jump;                  // Salida: indica si la instrucción es un salto (jump)
    wire WriteRegisterData_Src; // Salida: selecciona la fuente de datos para escribir en el registro

    // Instanciación del módulo MAIN_DECODER bajo prueba
    Main_Decoder UUT (
        .opcode(opcode),             // Conexión de la entrada opcode
        .funct3(funct3),             // Conexión de la entrada funct3
        .RegWrite(RegWrite),         // Conexión de la salida RegWrite
        .ImmSrc(ImmSrc),             // Conexión de la salida ImmSrc
        .ALU_src(ALU_src),           // Conexión de la salida ALU_src
        .MemWrite(MemWrite),         // Conexión de la salida MemWrite
        .Result_src(Result_src),     // Conexión de la salida Result_src
        .Branch(Branch),             // Conexión de la salida Branch
        .ALU_op(ALU_op),             // Conexión de la salida ALU_op
        .Jump(Jump),                 // Conexión de la salida Jump
        .WriteRegisterData_Src(WriteRegisterData_Src) // Conexión de la salida WriteRegisterData_Src
    );

    // Bloque inicial para configurar las pruebas
    initial begin
        $dumpfile("TB_MainDecoder.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, TB_MainDecoder);    // Volcar todas las variables del módulo para trazado

        // Prueba 1: Instrucción de carga (LOAD_W_B)
        opcode = 7'b0000011; // Opcode para LOAD_W_B
        funct3 = 3'b010;     // funct3 para LW (load word)
        #10;
        // Resultados esperados:
        // RegWrite = 1
        // ImmSrc = 3'b000 (Imm_Src_I)
        // ALU_src = 1
        // MemWrite = 0
        // Result_src = 2'b01
        // Branch = 0
        // ALU_op = 3'b000 (ADD)
        // Jump = 0
        // WriteRegisterData_Src = 0

        // Prueba 2: Instrucción de almacenamiento (STORE_W_B)
        opcode = 7'b0100011; // Opcode para STORE_W_B
        funct3 = 3'b010;     // funct3 para SW (store word)
        #10;
        // Resultados esperados:
        // RegWrite = 0
        // ImmSrc = 3'b001 (Imm_Src_S)
        // ALU_src = 1
        // MemWrite = 1
        // Result_src = XX (no relevante)
        // Branch = 0
        // ALU_op = 3'b000 (ADD)
        // Jump = 0
        // WriteRegisterData_Src = 0

        // Prueba 3: Instrucción de rama (BRANCH)
        opcode = 7'b1100011; // Opcode para BRANCH
        funct3 = 3'b000;     // funct3 para BEQ (branch if equal)
        #10;
        // Resultados esperados:
        // RegWrite = 0
        // ImmSrc = 3'b010 (Imm_Src_B)
        // ALU_src = 0
        // MemWrite = 0
        // Result_src = XX
        // Branch = 1
        // ALU_op = 3'b001 (SUB)
        // Jump = 0
        // WriteRegisterData_Src = 0

        // Prueba 4: Instrucción tipo I (ADDI)
        opcode = 7'b0010011; // Opcode para I_TYPE
        funct3 = 3'b000;     // funct3 para ADDI
        #10;
        // Resultados esperados:
        // RegWrite = 1
        // ImmSrc = 3'b000 (Imm_Src_I)
        // ALU_src = 1
        // MemWrite = 0
        // Result_src = 2'b00
        // Branch = 0
        // ALU_op = 3'b111 (SPECIAL)
        // Jump = 0
        // WriteRegisterData_Src = 0

        // Prueba 5: Instrucción de salto (JAL)
        opcode = 7'b1101111; // Opcode para JAL
        funct3 = 3'b000;     // funct3 no relevante
        #10;
        // Resultados esperados:
        // RegWrite = 1
        // ImmSrc = 3'b011 (Imm_Src_J)
        // ALU_src = X (no relevante)
        // MemWrite = 0
        // Result_src = 2'b10
        // Branch = 0
        // ALU_op = XXX
        // Jump = 1
        // WriteRegisterData_Src = 0

        // Prueba 6: Instrucción LUI
        opcode = 7'b0110111; // Opcode para LUI
        funct3 = 3'b000;     // funct3 no relevante
        #10;
        // Resultados esperados:
        // RegWrite = 1
        // ImmSrc = 3'b100 (Imm_Src_U)
        // ALU_src = X
        // MemWrite = 0
        // Result_src = XX
        // Branch = 0
        // ALU_op = XXX
        // Jump = 0
        // WriteRegisterData_Src = 1

        // Prueba 7: Instrucción desconocida (DEFAULT)
        opcode = 7'b0000000; // Opcode desconocido
        funct3 = 3'b000;     // funct3 no relevante
        #10;
        // Resultados esperados (según el default):
        // RegWrite = 1
        // ImmSrc = 3'b000
        // ALU_src = 1
        // MemWrite = 0
        // Result_src = 2'b01
        // Branch = 0
        // ALU_op = 3'bxxx
        // Jump = 0
        // WriteRegisterData_Src = 0

        // Finalizar la simulación
        $finish; // Terminar la simulación después de ejecutar las pruebas
    end
endmodule
