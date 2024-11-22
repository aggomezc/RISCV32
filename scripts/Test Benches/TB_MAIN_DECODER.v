`include "MAIN_DECODER.v" // Incluir el módulo MAIN_DECODER a testear

module TB_MainDecoder;
    // Declaración de señales de prueba
    reg [6:0] opcode;           // Entrada: opcode que define el tipo de instrucción
    reg [2:0] funct3;           // Entrada: campo funct3 que detalla la operación
    wire RegWrite;              // Salida: indica si se escribe en un registro
    wire [1:0] ImmSrc;          // Salida: determina el tipo de inmediato a generar
    wire ALU_src;               // Salida: selecciona entre operando o inmediato para la ALU
    wire MemWrite;              // Salida: indica si se realiza escritura en memoria
    wire [1:0] Result_src;      // Salida: selecciona la fuente del resultado
    wire Branch;                // Salida: indica si la instrucción es un branch
    wire [2:0] ALU_op;          // Salida: operación que realizará la ALU
    wire Jump;                  // Salida: indica si la instrucción es un salto (jump)

    // Instanciación del módulo MAIN_DECODER bajo prueba
    Main_Decoder UUT (
        .opcode(opcode),        // Conexión de la entrada opcode
        .funct3(funct3),        // Conexión de la entrada funct3
        .RegWrite(RegWrite),    // Conexión de la salida RegWrite
        .ImmSrc(ImmSrc),        // Conexión de la salida ImmSrc
        .ALU_src(ALU_src),      // Conexión de la salida ALU_src
        .MemWrite(MemWrite),    // Conexión de la salida MemWrite
        .Result_src(Result_src),// Conexión de la salida Result_src
        .Branch(Branch),        // Conexión de la salida Branch
        .ALU_op(ALU_op),        // Conexión de la salida ALU_op
        .Jump(Jump)             // Conexión de la salida Jump
    );

    // Bloque inicial para configurar las pruebas
    initial begin
        $dumpfile("TB_MainDecoder.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, TB_MainDecoder);    // Volcar todas las variables del módulo para trazado

        // Prueba 1: Instrucción tipo S (SW)
        #1 opcode = 7'b0100011; // Opcode para instrucciones tipo S (SW)
           funct3 = 3'b000;     // Campo funct3 para SW
        // Prueba 2: Instrucción tipo I (ADDI)
        #1 opcode = 7'b0010011; // Opcode para instrucciones tipo I (ADDI)
           funct3 = 3'b000;     // Campo funct3 para ADDI

        // Finalizar la simulación
        #2 $finish; // Terminar la simulación después de ejecutar las pruebas
    end
endmodule