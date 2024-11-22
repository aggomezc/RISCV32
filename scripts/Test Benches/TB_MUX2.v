`include "MUX2.v"

module TB_MUX2();
    reg [31:0] a;
    reg [31:0] b;
    reg sel;
    wire [31:0] out;

    MUX2 uut(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("TB_MUX2.vcd");
        $dumpvars(0, TB_MUX2);

        // Inicialización de las señales
        a = 32'hAAAAAAAA; b = 32'h55555555; sel = 0;
        #10; // Probar con sel = 0 (debería seleccionar 'a')

        sel = 1; // Probar con sel = 1 (debería seleccionar 'b')
        #10;

        a = 32'h12345678; b = 32'h87654321; sel = 0;
        #10; // Cambiar valores de 'a' y 'b' con sel = 0

        sel = 1; // Cambiar sel a 1 para seleccionar 'b'
        #10;

        a = 32'hDEADBEEF; b = 32'hCAFEBABE; sel = 0;
        #10; // Cambiar valores nuevamente con sel = 0

        sel = 1; // Probar con sel = 1
        #10;

        $finish; // Finalizar la simulación
    end
    
endmodule