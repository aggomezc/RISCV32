`include "ALU_DECODE.v" // Incluir el módulo ALU_DECODE a testear

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

        // Prueba 1: Configuración inicial de señales
        ALUOP = 3'b100;        // Asignar valor inicial a ALUOP
        funct3 = 3'b001;       // Asignar valor inicial a funct3

        #1 $finish;            // Finalizar la simulación después de 1 unidad de tiempo
    end
endmodule