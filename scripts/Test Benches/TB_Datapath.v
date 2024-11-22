`include "Datapath.v" // Incluir el módulo Datapath a testear

module TB_Datapath;
    // Declaración de señales de prueba
    reg CLK;             // Señal de reloj
    reg Reset;           // Señal de reinicio (Reset)

    // Instanciación del módulo Datapath bajo prueba
    Datapath UUT (
        .CLK(CLK),        // Conexión de la señal de reloj
        .Reset(Reset)     // Conexión de la señal de reinicio
    );

    // Bloque inicial para configurar las pruebas
    initial begin
        $dumpfile("TB_Datapath.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, TB_Datapath);    // Volcar todas las variables del módulo para trazado

        // Inicialización de señales
        Reset = 1;       // Activar el reinicio para inicializar el Datapath
        CLK = 0;         // Inicializar el reloj en 0
        #1 Reset = 0;    // Desactivar el reinicio tras 1 unidad de tiempo

        // Simulación principal
        #200 UUT.Dump_mem(); // Llamar a la función Dump_mem del módulo Datapath después de 119 unidades de tiempo

        // Finalizar la simulación
        #1 $finish;      // Terminar la simulación después de ejecutar Dump_mem
    end    

    // Generación del reloj
    always #2 CLK = ~CLK; // Alternar el reloj cada 2 unidades de tiempo (Periodo = 4)
endmodule
