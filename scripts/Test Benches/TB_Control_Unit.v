`include "CONTROL_UNIT.v" // Incluir el módulo CONTROL_UNIT a testear

module Control_Unit_TB;
    // Declaración de señales de prueba
    reg [6:0] opcode;       // Entrada: opcode de la instrucción
    reg [2:0] funct3;       // Entrada: campo funct3 de la instrucción
    reg [2:0] ALU_flags;    // Entrada: flags de la ALU (Zero, Sign, etc.)

    wire RegWrite;          // Salida: indica si se escribe en un registro
    wire [1:0] ImmSrc;      // Salida: selección del tipo de inmediato
    wire ALU_src;           // Salida: selecciona entre operando o inmediato para la ALU
    wire MemWrite;          // Salida: indica si se realiza escritura en memoria
    wire [1:0] Result_src;  // Salida: selecciona la fuente del resultado
    wire Branch;            // Salida: indica si la instrucción es un branch
    wire [2:0] ALU_op;      // Salida: operación que debe realizar la ALU
    wire Jump;              // Salida: indica si la instrucción es un salto (jump)
    wire PC_Src;            // Salida: selecciona la fuente del valor del PC

    // Instanciación del módulo CONTROL_UNIT bajo prueba
    Control_Unit UUT(
        .opcode(opcode),        // Conexión de la entrada opcode
        .funct3(funct3),        // Conexión de la entrada funct3
        .ALU_flags(ALU_flags),  // Conexión de los flags de la ALU

        .RegWrite(RegWrite),    // Conexión de la salida RegWrite
        .ImmSrc(ImmSrc),        // Conexión de la salida ImmSrc
        .ALU_src(ALU_src),      // Conexión de la salida ALU_src
        .MemWrite(MemWrite),    // Conexión de la salida MemWrite
        .Result_src(Result_src),// Conexión de la salida Result_src
        .PC_Src(PC_Src)         // Conexión de la salida PC_Src
    );

    // Bloque inicial para ejecutar las pruebas
    initial begin
        $dumpfile("Control_Unit_TB.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, Control_Unit_TB);    // Volcar todas las variables del módulo para trazado

        // Prueba 1: Instrucción I-type (ADDI)
        opcode = 7'b0010011; // Opcode para instrucciones tipo I
        funct3 = 3'b000;     // Funct3 para ADDI
        ALU_flags = 3'b100;  // Configuración inicial de flags
        #10;                 // Esperar 10 unidades de tiempo

        // Prueba 2: Instrucción de carga (LW)
        opcode = 7'b0000011; // Opcode para LW
        funct3 = 3'b010;     // Funct3 para LW
        ALU_flags = 3'b000;  // Flags sin impacto para esta prueba
        #10;                 // Esperar 10 unidades de tiempo

        // Prueba 3: Instrucción de almacenamiento (SW)
        opcode = 7'b0100011; // Opcode para SW
        funct3 = 3'b010;     // Funct3 para SW
        ALU_flags = 3'b010;  // Configuración de flags
        #10;                 // Esperar 10 unidades de tiempo

        // Prueba 4: Instrucción de branch (BNE)
        opcode = 7'b1100111; // Opcode para Branch
        funct3 = 3'b001;     // Funct3 para BNE
        ALU_flags = 3'b001;  // Configuración de flags
        #10;                 // Esperar 10 unidades de tiempo

        // Prueba 5: Instrucción de branch (BGE)
        opcode = 7'b1100111; // Opcode para Branch
        funct3 = 3'b101;     // Funct3 para BGE
        ALU_flags = 3'b010;  // Configuración de flags
        #10;                 // Esperar 10 unidades de tiempo

        // Finalizar la simulación
        $finish; // Terminar la simulación
    end
endmodule