`include "MUX3.v"

module TB_MUX3();
    reg [31:0] a;
    reg [31:0] b;
    reg [31:0] c;
    reg [1:0] sel;
    wire [31:0] out;

    MUX3 uut(
        .a(a),
        .b(b),
        .c(c),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("TB_MUX3.vcd");
        $dumpvars(0, TB_MUX3);

        // Inicialización de las señales
        a = 32'h11111111; b = 32'h22222222; c = 32'h33333333; sel = 2'b00;
        #10; // Probar con sel = 00 (debería seleccionar 'a')

        sel = 2'b01; // Probar con sel = 01 (debería seleccionar 'b')
        #10;

        sel = 2'b10; // Probar con sel = 10 (debería seleccionar 'c')
        #10;

        sel = 2'b11; // Probar con sel = 11 (debería seleccionar el valor por defecto)
        #10;

        // Cambiar los valores de 'a', 'b', y 'c'
        a = 32'hAAAA5555; b = 32'h5555AAAA; c = 32'hDEADBEEF;

        sel = 2'b00; // Verificar selección de 'a' con nuevos valores
        #10;

        sel = 2'b01; // Verificar selección de 'b' con nuevos valores
        #10;

        sel = 2'b10; // Verificar selección de 'c' con nuevos valores
        #10;

        sel = 2'b11; // Verificar selección por defecto con nuevos valores
        #10;

        $finish; // Finalizar la simulación
    end
    
endmodule