`include "d_flip_flop.v"

module TB_d_flip_flop();
    reg clk;
    reg rst;
    reg [31:0] d;
    wire [31:0] q;

    d_flip_flop uut(
        .clk(clk),
        .d(d),
        .rst(rst),
        .q(q)
    );

    // Generación del reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 unidades de tiempo
    end

    initial begin
        $dumpfile("TB_d_flip_flop.vcd");
        $dumpvars(0, TB_d_flip_flop);

        // Inicialización de las señales
        rst = 1; d = 32'h00000000;
        #10 rst = 0; d = 32'h12345678; // Desactivar reset y cargar un dato

        #10 d = 32'h87654321; // Cambiar el valor de entrada

        #20 rst = 1; // Activar reset, la salida debe ser 0
        #10 rst = 0; d = 32'hDEADBEEF; // Desactivar reset y cargar otro dato

        #20 $finish; // Finalizar la simulación
    end
    
endmodule