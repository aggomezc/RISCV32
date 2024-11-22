//*******************************************************
// Módulo: ALU_DECODE
// Funcionalidad:
// Este módulo decodifica las señales de control `ALUOP` y `funct3` para generar la señal `ALU_Control`,
// la cual indica la operación específica que debe realizar la Unidad Aritmético-Lógica (ALU).
//
// Entradas:
// - `ALUOP` [2:0]: Señal que indica la categoría general de operación para la ALU.
// - `funct3` [2:0]: Campo que especifica la operación detallada dentro de la categoría indicada por `ALUOP`.
//
// Salidas:
// - `ALU_Control` [2:0]: Señal de control específica para la ALU que determina la operación a ejecutar.
//
// Razón de introducción:
// El módulo `ALU_DECODE` se introduce para modularizar y simplificar la lógica de decodificación
// de instrucciones, permitiendo traducir combinaciones de señales de control en operaciones
// específicas de la ALU, lo que facilita la escalabilidad y mantenimiento del diseño.
//*******************************************************

module ALU_DECODE (
    input [2:0] ALUOP,          // Entrada: operación general de la ALU
    input [2:0] funct3,         // Entrada: especificador detallado de la operación

    output reg [2:0] ALU_Control // Salida: operación específica para la ALU
);
    // Parámetros: Definición de constantes para las operaciones
    parameter SPECIAL     = 3'b111,   // Categoría especial de operaciones
              ADD         = 3'b000,   // Operación de suma
              SUB         = 3'b001,   // Operación de resta
              LEFT_SHIFT  = 3'b011,   // Operación de desplazamiento a la izquierda
              ANDD        = 3'b010;   // Operación lógica AND

    // Bloque combinacional: Decodificación de señales de control
    always @ (ALUOP or funct3) begin
        case (ALUOP)
            SPECIAL: begin
                if (funct3 == ADD) begin
                    ALU_Control = ADD;        // Operación ADD en categoría SPECIAL
                end else if (funct3 == 3'b001) begin
                    ALU_Control = LEFT_SHIFT; // Operación LEFT_SHIFT en categoría SPECIAL
                end else if (funct3 == 3'b111) begin
                    ALU_Control = ANDD;       // Operación AND en categoría SPECIAL
                end else begin
                    ALU_Control = ADD;        // Valor por defecto en categoría SPECIAL
                end
            end

            3'b000: begin
                ALU_Control = ADD;            // Operación ADD cuando ALUOP es 000
            end
            3'b001: begin
                ALU_Control = SUB;            // Operación SUB cuando ALUOP es 001
            end

            default: ALU_Control = ADD;       // Valor por defecto: ADD
        endcase
    end
endmodule
