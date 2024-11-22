////////////////////////////////////////////////////////////
// Módulo: PC_BRANCH_ADDER
// Funcionalidad:
// Este módulo calcula la nueva dirección del contador de programa (PC)
// cuando se ejecuta una instrucción de rama (branch). Suma el valor actual
// del PC con un desplazamiento de rama, ajustando la dirección según sea necesario.
//
// Entradas:
// - `PC_itself` [31:0]: Valor actual del contador de programa.
// - `branch_offset` [31:0]: Desplazamiento calculado a partir de la instrucción de rama.
//
// Salidas:
// - `pc` [31:0]: Nueva dirección del contador de programa después de aplicar el desplazamiento.
//
// Razón de introducción:
// Las instrucciones de rama alteran el flujo secuencial del programa. Este módulo es esencial
// para calcular la dirección de destino a la que debe saltar el procesador cuando se cumplen
// ciertas condiciones, permitiendo una ejecución correcta de bucles, condiciones y saltos.
////////////////////////////////////////////////////////////

module PC_BRANCH_ADDER(
    input [31:0] PC_itself,        // Entrada: Valor actual del PC
    input [31:0] branch_offset,    // Entrada: Desplazamiento de rama
    output [31:0] pc               // Salida: Nueva dirección del PC
);

    // Cálculo de la nueva dirección del PC:
    // - Se suma el valor actual del PC con el desplazamiento de rama dividido entre 4.
    // - El desplazamiento de 2 bits (>> 2) ajusta el offset para alinearlo con direcciones de palabras.
    // - Se aplica una máscara AND con 0x0000FFFF para limitar la dirección al espacio de memoria permitido.
    // - También evita problemas con dividir entre 4 un número en complemento a dos, y obtener unos adicionales
    // - en las posiciones significativas
    assign pc = (PC_itself + (branch_offset >> 2)) & 32'h0000FFFF;

endmodule
