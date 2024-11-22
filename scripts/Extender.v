////////////////////////////////////////////////////////////
// Módulo: EXTENSION
// Funcionalidad:
// Este módulo realiza la extensión de inmediatos a 32 bits
// para diferentes tipos de instrucciones en un procesador RISC-V.
// Dependiendo del tipo de instrucción (especificado por `ImmControl`),
// extrae y extiende los campos inmediatos de la instrucción `Instr`
// para generar un valor inmediato extendido a 32 bits (`ExtendedImm`).
//
// Entradas:
// - `Instr` [31:0]: La instrucción completa desde la cual se extraen los campos inmediatos.
// - `ImmControl` [2:0]: Señal de control que indica el tipo de inmediato a generar.
//   Los tipos soportados son:
//   - `I`: Tipo I (inmediato de 12 bits)
//   - `S`: Tipo S (inmediato de 12 bits para almacenamiento)
//   - `B`: Tipo B (inmediato de 13 bits para ramas)
//   - `J`: Tipo J (inmediato de 21 bits para saltos)
//   - `U`: Tipo U (inmediato de 20 bits para cargas superiores)
//
// Salidas:
// - `ExtendedImm` [31:0]: El inmediato extendido a 32 bits.
//
// Razón de introducción:
// En arquitecturas como RISC-V, diferentes tipos de instrucciones requieren
// la manipulación de inmediatos de distintos tamaños y formatos. Este módulo
// abstrae la lógica de extracción y extensión de los inmediatos, facilitando
// el manejo consistente y modular de los mismos en el diseño del procesador.
////////////////////////////////////////////////////////////

module EXTENSION (
    input [31:0] Instr,            // Entrada: Instrucción completa
    input [2:0] ImmControl,        // Entrada: Control del tipo de inmediato
    output reg [31:0] ExtendedImm  // Salida: Inmediato extendido a 32 bits
);
    // Parámetros que definen los tipos de inmediatos
    parameter I = 3'b000,  // Tipo I
              S = 3'b001,  // Tipo S
              B = 3'b010,  // Tipo B
              J = 3'b011,  // Tipo J
              U = 3'b100;  // Tipo U

    // Bloque always: Extensión de inmediatos según ImmControl
    always @(Instr or ImmControl) begin
        case (ImmControl)
            // Tipo I: Inmediato de 12 bits, extensión de signo
            I:  ExtendedImm = {{20{Instr[31]}}, Instr[31:20]};
            
            // Tipo S: Inmediato de 12 bits para almacenamiento, extensión de signo
            S:  ExtendedImm = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
            
            // Tipo B: Inmediato de 13 bits para ramas, extensión de signo
            B:  ExtendedImm = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
            
            // Tipo U: Inmediato de 20 bits, se coloca en los bits más significativos
            U:  ExtendedImm = {Instr[31:12], {12{1'b0}}};

            // Tipo J: Inmediato de 21 bits para saltos, extensión de signo
            J:  ExtendedImm = {{11{Instr[31]}}, Instr[31], Instr[19:12], Instr[20], Instr[30:21], 1'b0};

            // Caso por defecto: Inmediato cero
            default: ExtendedImm = 32'b0;
        endcase
    end
endmodule
