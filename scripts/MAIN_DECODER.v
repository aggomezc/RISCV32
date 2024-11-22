////////////////////////////////////////////////////////////
// Módulo: Main_Decoder
// Funcionalidad:
// Este módulo implementa la unidad de decodificación principal
// para un procesador. Basándose en el campo de operación (`opcode`)
// y el campo de función (`funct3`), genera las señales de control
// necesarias para dirigir las operaciones del procesador.
// Estas señales incluyen controles para escritura en registros,
// selección de inmediatos, operaciones de la ALU, control de memoria,
// y lógica de salto y rama.
//
// Entradas:
// - `opcode` [6:0]: Código de operación que indica el tipo de instrucción.
// - `funct3` [2:0]: Campo de función que proporciona información adicional sobre la instrucción.
//
// Salidas:
// - `RegWrite`: Habilita la escritura en el banco de registros.
// - `ImmSrc` [2:0]: Selecciona el tipo de inmediato a utilizar.
// - `ALU_src`: Determina la fuente del segundo operando de la ALU.
// - `MemWrite`: Habilita la escritura en memoria.
// - `Result_src` [1:0]: Selecciona el origen del dato para escribir en el registro.
// - `Branch`: Indica si la instrucción es una operación de rama condicional.
// - `ALU_op` [2:0]: Señal de control para la ALU, determina la operación a realizar.
// - `Jump`: Indica si la instrucción es un salto incondicional.
// - `WriteRegisterData_Src`: Selecciona la fuente de datos para escribir en el registro.
//
// Razón de introducción:
// El módulo Main_Decoder centraliza la lógica de decodificación de instrucciones,
// generando las señales de control necesarias basadas en el opcode y funct3.
// Esto facilita el diseño y mantenimiento del procesador, permitiendo agregar
// o modificar instrucciones de manera modular y eficiente.
////////////////////////////////////////////////////////////

module Main_Decoder (
    input [6:0] opcode,        // Entrada: código de operación
    input [2:0] funct3,        // Entrada: campo de función

    output reg RegWrite,               // Salida: habilitación de escritura en registros
    output reg [2:0] ImmSrc,           // Salida: selección del inmediato
    output reg ALU_src,                // Salida: selección del segundo operando de la ALU
    output reg MemWrite,               // Salida: habilitación de escritura en memoria
    output reg [1:0] Result_src,       // Salida: selección del origen del dato para registro
    output reg Branch,                 // Salida: señal de rama condicional
    output reg [2:0] ALU_op,           // Salida: operación de la ALU
    output reg Jump,                   // Salida: señal de salto incondicional
    output reg WriteRegisterData_Src   // Salida: selección de fuente para escritura en registro
);

    // Parámetros para los diferentes opcodes
    parameter  LOAD_W_B = 7'b0000011,    // Instrucciones de carga (load word/byte)
               STORE_W_B = 7'b0100011,   // Instrucciones de almacenamiento (store word/byte)
               R_TYPE = 7'b0110011,      // Instrucciones tipo R
               BRANCH = 7'b1100011,      // Instrucciones de rama condicional
               I_TYPE = 7'b0010011,      // Instrucciones tipo I
               JAL = 7'b1101111,         // Instrucción de salto y enlace (JAL)
               LUI = 7'b0110111;         // Instrucción de cargar inmediato superior (LUI)

    // Parámetros para las operaciones de la ALU
    parameter SPECIAL = 3'b111,
               ADD = 3'b000,
               SUB = 3'b001,
               LEFT_SHIFT = 3'b011;

    // Parámetros para la selección del inmediato
    parameter Imm_Src_I = 3'b000,    // Tipo I
              Imm_Src_S = 3'b001,    // Tipo S
              Imm_Src_B = 3'b010,    // Tipo B
              Imm_Src_J = 3'b011,    // Tipo J
              Imm_Src_U = 3'b100;    // Tipo U

    // Bloque always: Generación de señales de control basadas en opcode y funct3
    always @(opcode or funct3) begin
        case (opcode)
            LOAD_W_B: begin
                // Instrucciones de carga
                RegWrite = 1;                  // Habilitar escritura en registros
                ImmSrc =   Imm_Src_I;          // Inmediato tipo I
                ALU_src =  1;                  // ALU_src toma el inmediato
                MemWrite = 0;                  // No se escribe en memoria
                Result_src = 2'b01;            // Resultado viene de la memoria
                Branch =  0;                   // No es una instrucción de rama
                ALU_op = ADD;                  // Operación de suma en la ALU (para calcular dirección)
                Jump = 0;                      // No es una instrucción de salto
                WriteRegisterData_Src = 0;     // Datos para el registro vienen de Result_src
            end

            STORE_W_B: begin
                // Instrucciones de almacenamiento
                RegWrite = 0;                  // No se escribe en registros
                ImmSrc =   Imm_Src_S;          // Inmediato tipo S
                ALU_src =  1;                  // ALU_src toma el inmediato
                MemWrite = 1;                  // Habilitar escritura en memoria
                Result_src = 2'bxx;            // No aplica
                Branch =  0;                   // No es una instrucción de rama
                ALU_op = ADD;                  // Operación de suma en la ALU (para calcular dirección)
                Jump = 0;                      // No es una instrucción de salto
                WriteRegisterData_Src = 0;     // No aplica
            end

            BRANCH: begin
                // Instrucciones de rama condicional
                RegWrite = 0;                  // No se escribe en registros
                ImmSrc =   Imm_Src_B;          // Inmediato tipo B
                ALU_src =  0;                  // ALU_src toma el valor del registro
                MemWrite = 0;                  // No se escribe en memoria
                Result_src = 2'bxx;            // No aplica
                Branch =  1;                   // Es una instrucción de rama
                ALU_op = SUB;                  // Operación de resta en la ALU (para comparación)
                Jump = 0;                      // No es un salto incondicional
                WriteRegisterData_Src = 0;     // No aplica
            end

            I_TYPE: begin
                // Instrucciones tipo I (operaciones aritméticas inmediatas)
                RegWrite = 1;                  // Habilitar escritura en registros
                ImmSrc =   Imm_Src_I;          // Inmediato tipo I
                ALU_src =  1;                  // ALU_src toma el inmediato
                MemWrite = 0;                  // No se escribe en memoria
                Result_src = 2'b00;            // Resultado viene de la ALU
                Branch =  0;                   // No es una instrucción de rama
                ALU_op =   SPECIAL;            // Operación determinada por funct3 y ALU_Decode
                Jump = 0;                      // No es un salto incondicional
                WriteRegisterData_Src = 0;     // Datos para el registro vienen de Result_src
            end

            JAL: begin
                // Instrucción de salto y enlace
                RegWrite = 1;                  // Habilitar escritura en registros (guarda la dirección de retorno)
                ImmSrc =   Imm_Src_J;          // Inmediato tipo J
                ALU_src =  1'bx;               // No aplica
                MemWrite = 0;                  // No se escribe en memoria
                Result_src = 2'b10;            // Resultado es PC + 4 (dirección de retorno)
                Branch =  0;                   // No es una rama condicional
                ALU_op =   3'bxxx;             // No aplica
                Jump = 1;                      // Es un salto incondicional
                WriteRegisterData_Src = 0;     // Datos para el registro vienen de Result_src
            end

            LUI: begin
                // Instrucción de cargar inmediato superior
                RegWrite = 1;                  // Habilitar escritura en registros
                ImmSrc =   Imm_Src_U;          // Inmediato tipo U
                ALU_src =  1'bx;               // No aplica
                MemWrite = 0;                  // No se escribe en memoria
                Result_src = 2'bx;             // No aplica
                Branch =  0;                   // No es una instrucción de rama
                ALU_op =   3'bxxx;             // No aplica
                Jump = 0;                      // No es un salto
                WriteRegisterData_Src = 1;     // Datos vienen directamente del inmediato extendido
            end

            default: begin
                // Caso por defecto: Se puede ajustar según necesidades, pero realmente si se cae aquí, no importa lo que está sucediendo
                RegWrite = 1;
                ImmSrc =   Imm_Src_I;
                ALU_src =  1;
                MemWrite = 0;
                Result_src = 2'b00;
                Branch =  0;
                ALU_op = SPECIAL;
                Jump = 0;
                WriteRegisterData_Src = 0;
            end
        endcase
    end
endmodule












