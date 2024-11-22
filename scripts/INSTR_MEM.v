////////////////////////////////////////////////////////////
// Módulo: MEM (Memoria de Instrucciones)
// Funcionalidad:
// Este módulo simula una memoria de instrucciones para un procesador.
// Carga las instrucciones desde un archivo externo y las proporciona
// en base a la dirección del contador de programa (PC).
//
// Entradas:
// - `PC` [31:0]: Dirección del contador de programa que indica la instrucción a leer.
//
// Salidas:
// - `Instr` [31:0]: Instrucción leída de la memoria correspondiente a la dirección `PC`.
//
// Razón de introducción:
// El módulo MEM es esencial para proporcionar las instrucciones al procesador
// durante la ejecución. Permite simular la lectura de instrucciones almacenadas
// en memoria, facilitando el desarrollo y prueba del procesador en entornos de simulación.
////////////////////////////////////////////////////////////

module MEM (
    input [31:0] PC,               // Entrada: Dirección del contador de programa
    output reg [31:0] Instr        // Salida: Instrucción correspondiente
);
    // Definición de la memoria de instrucciones como un arreglo
    reg [31:0] mem_arr [0:29];     // Memoria de 30 instrucciones de 32 bits cada una

    // Bloque inicial para cargar las instrucciones desde un archivo externo
    initial begin
        $readmemh("INSTRS/HEX_FILE_CORRECTO.hex", mem_arr); // Carga de instrucciones en formato hexadecimal
    end

    // Bloque siempre activo para asignar la instrucción según el PC
    always @(*) begin
        Instr = mem_arr[PC];       // Asignación de la instrucción correspondiente al valor de PC
    end

endmodule
