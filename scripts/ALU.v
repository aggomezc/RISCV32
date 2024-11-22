
module ALU (
    input [31:0] scrA, 
    input [31:0] scrB,
    input [2:0] AluControl, 
    output reg signed [31:0] ALUresult, 
    output reg [1:0]Flag    //Sign, Zero
);
//*******************************************************
// Módulo: ALU (Unidad Aritmético-Lógica)
// Funcionalidad:
// Este módulo implementa una ALU que realiza operaciones aritméticas y lógicas básicas
// basadas en la señal de control `AluControl`. Las operaciones soportadas incluyen suma,
// resta, AND lógico y desplazamiento a la izquierda. Además, genera banderas (flags) para
// indicar si el resultado es cero o negativo.
//
// Entradas:
// - `scrA` [31:0]: Primer operando de 32 bits.
// - `scrB` [31:0]: Segundo operando de 32 bits.
// - `AluControl` [2:0]: Señal de control que determina la operación a realizar.
//
// Salidas:
// - `ALUresult` [31:0]: Resultado de la operación realizada.
// - `Flag` [1:0]:
//   - `Flag[ZERO]`: Indica si el resultado es cero (1 si es cero, 0 en caso contrario).
//   - `Flag[SIGN]`: Indica si el resultado es negativo (1 si es negativo, 0 en caso contrario).
//
// Razón de introducción:
// La ALU es un componente fundamental en sistemas digitales y procesadores. Este módulo
// proporciona las operaciones esenciales necesarias para ejecutar instrucciones y realizar
// cálculos, además de proveer información adicional sobre el resultado a través de las banderas.
//las banderas se utilizan principalmente para calcular el branch adecuado
//*******************************************************
parameter ADD = 0;
parameter SUB = 1;
parameter ANDD = 2;
parameter LSHIFT = 3; 

parameter   ZERO = 0,
            SIGN = 1;

always @(*) begin
    case (AluControl)
    ADD:  begin 
        ALUresult = scrA + scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
    end 

    SUB:  begin
        ALUresult = scrA - scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
    end
    
    ANDD: begin
        ALUresult = scrA & scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;
    end

    LSHIFT: begin
        ALUresult = scrA << scrB;
        Flag[ZERO] = (ALUresult == 0) ? 1:0 ;
        Flag[SIGN] = (ALUresult < 0) ? 1:0;

    end

    default: begin
        ALUresult = 0;
        Flag[ZERO] =0;
        Flag[SIGN] =0;
    end 
    endcase

end
    
endmodule









