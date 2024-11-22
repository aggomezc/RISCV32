////////////////////////////////////////////////////////////
// Módulo: DynamicMemory
// Funcionalidad:
// Este módulo implementa una memoria dinámica que permite
// operaciones de lectura y escritura en una memoria simulada.
// Soporta escritura síncrona y lectura asíncrona. Las operaciones
// soportadas incluyen almacenar palabras completas (store word - sw)
// y almacenar bytes individuales (store byte - sb).
//
// Entradas:
// - `CLK`: Señal de reloj para sincronizar las operaciones de escritura.
// - `WE`: Señal de habilitación de escritura (Write Enable).
// - `funct3` [2:0]: Campo que especifica el tipo de operación (sw, sb).
// - `ADDRESS` [31:0]: Dirección de memoria para lectura/escritura.
// - `WRITE_DATA` [31:0]: Datos a escribir en memoria.
//
// Salidas:
// - `READ_DATA` [31:0]: Datos leídos de la memoria.
//
// Razón de introducción:
// Este módulo simula una memoria de datos para un procesador,
// permitiendo probar operaciones de carga y almacenamiento.
// Es fundamental para validar el funcionamiento del procesador
// en operaciones que involucran acceso a memoria.
////////////////////////////////////////////////////////////

module DynamicMemory(
    input CLK,
    input WE,
    input [2:0] funct3,
    input [31:0] ADDRESS,
    input [31:0] WRITE_DATA,  
    output reg [31:0] READ_DATA
    // Lectura asíncrona y escritura síncrona
);
    // Parámetros que definen las operaciones soportadas
    parameter sw = 2; // Código para store word
    parameter sb = 0; // Código para store byte

    // Definición de la memoria como un arreglo de bytes
    reg [7:0] MEMORY_ARRAY [0:1024];

    // Tarea para imprimir el contenido de la memoria en un archivo
    // task print_memory;
    //     integer file;
    //     integer i;
    //     file = $fopen("MemDUMP.txt", "w");
    //     if (file == 0) begin
    //         $display("Error opening file");
    //         $finish;
    //     end

    //     $fwrite(file, "Memory contents:\n");
    //     for (i = 0; i < 1024; i = i + 1) begin
    //         $fwrite(file, "%h\n", MEMORY_ARRAY[i]);
    //     end

    //     $fclose(file);
    // endtask
    task print_memory;
    integer file;
    integer i;
    file = $fopen("MemDUMP.txt", "w");
    if (file == 0) begin
        $display("Error opening file");
        $finish;
    end

    $fwrite(file, "Memory contents:\n");
    for (i = 0; i < 1024; i = i + 1) begin
        $fwrite(file, "%08h: %02h\n", i, MEMORY_ARRAY[i]);
    end

    $fclose(file);
endtask
    // Escritura síncrona en memoria
    always @(posedge CLK) begin
        if (WE) begin
            if (funct3 == sw) begin // Si es una operación store word
                // Almacenar los 4 bytes de WRITE_DATA en direcciones consecutivas
                MEMORY_ARRAY[ADDRESS]     <= WRITE_DATA[31:24];
                MEMORY_ARRAY[ADDRESS + 1] <= WRITE_DATA[23:16];
                MEMORY_ARRAY[ADDRESS + 2] <= WRITE_DATA[15:8];
                MEMORY_ARRAY[ADDRESS + 3] <= WRITE_DATA[7:0];
            end
            else if (funct3 == sb) begin // Si es una operación store byte
                // Almacenar un byte de WRITE_DATA en la dirección especificada
                MEMORY_ARRAY[ADDRESS] <= WRITE_DATA[7:0];
                // Se considera una estructura Big Endian
            end
        end
    end

    // Lectura asíncrona de memoria
    always @(*) begin
        // Lectura de una palabra completa (4 bytes) desde la memoria
        READ_DATA[31:24] = MEMORY_ARRAY[ADDRESS];
        READ_DATA[23:16] = MEMORY_ARRAY[ADDRESS + 1];
        READ_DATA[15:8]  = MEMORY_ARRAY[ADDRESS + 2];
        READ_DATA[7:0]   = MEMORY_ARRAY[ADDRESS + 3];
    end

endmodule
