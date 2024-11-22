`include "INSTR_MEM.v" // Incluir el módulo INSTR_MEM (memoria de instrucciones) a testear

module INSTR_MEM_TB;
    // Declaración de señales de prueba
    reg clk;               // Señal de reloj
    reg [31:0] PC;         // Entrada: dirección del contador de programa (PC)
    wire [31:0] Inst;      // Salida: instrucción en la dirección especificada por el PC

    // Instanciación del módulo MEM bajo prueba
    MEM UUT (
        .CLK(clk),          // Conexión de la señal de reloj
        .PC(PC),            // Conexión de la entrada PC
        .Instr(Inst)        // Conexión de la salida Inst
    );

    // Bloque inicial para configurar las pruebas
    initial begin
        $dumpfile("MEM_TEST.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, INSTR_MEM_TB); // Volcar todas las variables del módulo para trazado

        // Inicialización del reloj
        clk = 0; // Inicializar el reloj en 0

        // Prueba 1: Leer instrucción en la dirección 1
        #1 PC = 1;        // Establecer PC en la dirección 1
        #1 clk = ~clk;    // Generar flanco positivo del reloj
        #1 clk = ~clk;    // Generar flanco negativo del reloj

        // Prueba 2: Leer instrucción en la dirección 2
        #1 PC = 2;        // Cambiar PC a la dirección 2
        #1 clk = ~clk;    // Generar flanco positivo del reloj
        #1 clk = ~clk;    // Generar flanco negativo del reloj

        // Prueba 3: Leer instrucción en la dirección 3
        #1 PC = 3;        // Cambiar PC a la dirección 3
        #1 clk = ~clk;    // Generar flanco positivo del reloj
        #1 clk = ~clk;    // Generar flanco negativo del reloj

        // Finalizar la simulación
        #1 $finish; // Terminar la simulación después de ejecutar las pruebas
    end

    // Generación del reloj (alternativa, comentada)
    // always #5 clk = ~clk; // Alternar el reloj cada 5 unidades de tiempo (periodo = 10)
endmodule