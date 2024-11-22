`include "PC_BRANCH_ADDER.v"

module TB_PC_BRANCH_ADDER();
    reg [31:0] PC_itself;
    reg [31:0] branch_offset;
    wire [31:0] pc;

    PC_BRANCH_ADDER uut(
        .PC_itself(PC_itself),
        .branch_offset(branch_offset),
        .pc(pc)
    );

    initial begin
        $dumpfile("TB_PC_BRANCH_ADDER.vcd");
        $dumpvars(0, TB_PC_BRANCH_ADDER);

        // Inicialización de señales y casos de prueba
        PC_itself = 32'h00000000; branch_offset = 32'h00000004;
        #10; // Probar con PC en 0 y offset pequeño

        PC_itself = 32'h00000010; branch_offset = 32'h00000008;
        #10; // Probar con PC en 16 y offset intermedio

        PC_itself = 32'h0000FF00; branch_offset = 32'hFFFFFFFC;
        #10; // Probar con PC en valor alto y offset negativo

        PC_itself = 32'h0000FFFF; branch_offset = 32'h00000010;
        #10; // Probar con PC en máximo valor permitido y offset pequeño

        PC_itself = 32'hFFFFFF00; branch_offset = 32'h00000004;
        #10; // Probar con PC en valor alto (signo extendido) y offset pequeño

        PC_itself = 32'h00000000; branch_offset = 32'h00000000;
        #10; // Probar con PC y offset en 0

        $finish; // Finalizar la simulación
    end
    
endmodule