`include "ALU.v" // Incluir el módulo ALU a testear

module TB_ALU();
    // Declaración de señales de prueba
    reg [31:0] scrA;           // Operando A de la ALU
    reg [31:0] scrB;           // Operando B de la ALU
    reg [2:0] AluControl;      // Señal de control para determinar la operación
    wire [31:0] ALUresult;     // Salida de la operación de la ALU
    wire [2:0] Flag;           // Salida de flags (Zero, Carry, Overflow, Sign)

    // Instanciación del módulo ALU bajo prueba
    ALU uut(
        .scrA(scrA),           // Conexión de la señal scrA
        .scrB(scrB),           // Conexión de la señal scrB
        .AluControl(AluControl), // Conexión de la señal de control
        .ALUresult(ALUresult), // Conexión de la salida ALUresult
        .Flag(Flag)            // Conexión de la salida de flags
    );

    // Bloque inicial para ejecutar las pruebas
    initial begin
        // Configuración para generar un archivo de salida para la simulación
        $dumpfile("TB_ALU.vcd"); // Nombre del archivo de salida
        $dumpvars(0, TB_ALU);    // Volcar todas las variables del módulo para su trazado

        // Primera prueba: Operación ADD (AluControl = 0)
        #1 scrA = 32'h200476;    // Valor inicial del operando A
        #1 scrB = 32'hFFFFFFFC;  // Valor inicial del operando B
        AluControl = 0;          // Señal de control para la operación ADD

        // Segunda prueba: Operación CMP (AluControl = 3'b100)
        #1 scrA = 32'h00000035;  // Cambiar valor de scrA
        scrB = 32'h00000034;     // Cambiar valor de scrB
        AluControl = 3'b010;     // Señal de control para la operación CMP

        #10 $finish; // Finalizar la simulación tras 10 unidades de tiempo
    end
endmodule