`include "Datapath.v"

module TB_Datapath;
    reg CLK;
    reg Reset;

    // Instantiate the module
    Datapath UUT (
        .CLK(CLK),
        .Reset(Reset)
    );

    initial begin

        $dumpfile(
            "TB_Datapath.vcd"
        );
    
        $dumpvars(
            0, TB_Datapath
        );

        Reset = 1;
        CLK = 0;
        #1 Reset =0; 
        #120 $finish;
    end    
    
    always #2 CLK = ~CLK;

endmodule