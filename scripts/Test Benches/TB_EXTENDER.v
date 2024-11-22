`include "EXTENSION.v"

////////////////////////////////////////////////////////////
// Banco de Pruebas: EXTENSION_TB
// Objetivo de la prueba:
// Verificar que el módulo EXTENSION genera correctamente
// los inmediatos extendidos para diferentes tipos de instrucciones.

// Estímulos:
// - Aplicar diferentes valores de Instr y variar ImmControl
//   para cubrir todos los tipos de inmediatos:
//     - Tipo I, S, B, U, J.

// Descripción de resultados esperados:
// - ExtendedImm debe contener el inmediato correctamente
//   extraído y extendido según el tipo especificado por ImmControl.
////////////////////////////////////////////////////////////

module EXTENSION_TB();
    // Declaración de señales de prueba
    reg [31:0] Instr;
    reg [2:0] ImmControl;
    wire [31:0] ExtendedImm;

    // Instanciación del módulo EXTENSION bajo prueba
    EXTENSION UUT (
        .Instr(Instr),
        .ImmControl(ImmControl),
        .ExtendedImm(ExtendedImm)
    );

    // Parámetros para los tipos de inmediato
    parameter I = 3'b000,
              S = 3'b001,
              B = 3'b010,
              J = 3'b011,
              U = 3'b100;

    // Bloque inicial para ejecutar la prueba
    initial begin
        $dumpfile("EXTENSION_TB.vcd"); // Archivo de salida para la simulación
        $dumpvars(0, EXTENSION_TB);    // Volcar todas las variables del módulo para trazado

        // Prueba 1: Tipo I
        Instr = 32'hFFF0F0F0; // Inmediato con signo negativo
        ImmControl = I;
        #10;
        // Se espera que ExtendedImm sea 32'hFFFFFFFF

        // Prueba 2: Tipo S
        Instr = 32'h00F0F0F0;
        ImmControl = S;
        #10;
        // Se espera que ExtendedImm sea 32'h00000001

        // Prueba 3: Tipo B
        Instr = 32'h0F0F0F0F;
        ImmControl = B;
        #10;
        // Se espera que ExtendedImm sea 32'h00000FFE

        // Prueba 4: Tipo U
        Instr = 32'h12345000;
        ImmControl = U;
        #10;
        // Se espera que ExtendedImm sea 32'h12345000

        // Prueba 5: Tipo J
        Instr = 32'hFEDCBA98;
        ImmControl = J;
        #10;
        // Se espera que ExtendedImm sea 32'hFFFCBFDC
        $finish;
    end
endmodule
