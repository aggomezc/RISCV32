`include "INSTR_MEM.v" // Incluir el módulo INSTR_MEM (memoria de instrucciones) a testear
////////////////////////////////////////////////////////////
// Banco de Pruebas: INSTR_MEM_TB
// Objetivo de la prueba:
// Verificar que el módulo MEM lee correctamente las instrucciones
// desde la memoria en función de diferentes valores del contador
// de programa (PC).

// Estímulos:
// - Variar la señal PC para diferentes direcciones de memoria.
// - Generar flancos de reloj para simular el comportamiento síncrono.

// Descripción de resultados esperados:
// - La salida `Inst` debe contener la instrucción correcta almacenada
//   en la dirección especificada por `PC`.
// - Se verificará que las instrucciones leídas coinciden con las
//   cargadas en la memoria desde el archivo de instrucciones.
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
    
    
    initial begin
        $dumpfile("MEM_TEST.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, INSTR_MEM_TB); // Volcar todas las variables del módulo para trazado

        // El reloj se va accionando, se incrementa el PC.clk
        // de esta manera, se revisa la lectura en los flancos
        // y si se leyó correctamente los contenidos del archivo
        // de instrucciones
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

endmodule