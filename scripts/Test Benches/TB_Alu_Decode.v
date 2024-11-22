`include "ALU_DECODE.v" 

module ALU_DECODE_TB();
    // Declaración de señales de prueba
    reg [2:0] ALUOP;          // Entrada: operación de la ALU (ALUOP)
    reg [2:0] funct3;         // Entrada: campo funct3 del conjunto de instrucciones
    wire [2:0] ALU_Control;   // Salida: señal de control de la ALU derivada de ALUOP y funct3

    // Instanciación del módulo ALU_DECODE bajo prueba
    ALU_DECODE UUT(
        .ALUOP(ALUOP),        // Conexión de la entrada ALUOP
        .funct3(funct3),      // Conexión de la entrada funct3
        .ALU_Control(ALU_Control) // Conexión de la salida ALU_Control
    );

    // Bloque inicial para ejecutar la prueba
    initial begin
        $dumpfile("ALU_DECODE_TB.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, ALU_DECODE_TB);    // Volcar todas las variables del módulo para trazado

        // Objetivo de la prueba:
        // Validar que el módulo ALU_DECODE produce correctamente la salida ALU_Control
        // para todas las combinaciones significativas de ALUOP y funct3.

        // Estímulos: 
        // Prueba 1: Caso SPECIAL con ADD
        ALUOP = 3'b111;        
        funct3 = 3'b000;       // Se espera ALU_Control = 3'b000
        #10;

        // Prueba 2: Caso SPECIAL con LEFT_SHIFT
        ALUOP = 3'b111;        
        funct3 = 3'b001;       // Se espera ALU_Control = 3'b011
        #10;

        // Prueba 3: Caso SPECIAL con ANDD
        ALUOP = 3'b111;        
        funct3 = 3'b111;       // Se espera ALU_Control = 3'b010
        #10;

        // Prueba 4: Caso ADD cuando ALUOP es 000
        ALUOP = 3'b000;        
        funct3 = 3'b101;       // Se espera ALU_Control = 3'b000
        #10;

        // Prueba 5: Caso SUB cuando ALUOP es 001
        ALUOP = 3'b001;        
        funct3 = 3'b010;       // Se espera ALU_Control = 3'b001
        #10;

        // Prueba 6: Caso DEFAULT
        ALUOP = 3'b010;        
        funct3 = 3'b101;       // Se espera ALU_Control = 3'b000
        #10;

        // Finalizar simulación
        $finish;
    end
endmodule
