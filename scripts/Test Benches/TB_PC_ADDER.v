`include "PC_ADDER.v"

module TB_PC_ADDER();
    reg [31:0] PC_itself;
    wire [31:0] pc;

    PC_ADDER uut(
        .PC_itself(PC_itself),
        .pc(pc)
    );

    initial begin
        $dumpfile("TB_PC_ADDER.vcd");
        $dumpvars(0, TB_PC_ADDER);

        // Inicialización de las señales
        PC_itself = 32'h00000000;
        #10; // Probar con PC inicial en 0

        PC_itself = 32'h00000001;
        #10; // Probar con PC inicial en 1

        PC_itself = 32'h000000FF;
        #10; // Probar con PC inicial en 255 (0xFF)

        PC_itself = 32'hFFFFFFFE;
        #10; // Probar con PC inicial cercano al máximo valor de 32 bits

        PC_itself = 32'hFFFFFFFF;
        #10; // Probar con PC en el máximo valor de 32 bits

        $finish; // Finalizar la simulación
    end
    
endmodule