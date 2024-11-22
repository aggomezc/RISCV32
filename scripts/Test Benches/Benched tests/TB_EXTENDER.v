`include "Extender.v"

module TB_EXTENSION;


    // Signals
    reg [31:0] Instr;
    reg [1:0] ImmControl;
    wire [31:0] ExtendedImm;

    // Parameters
    parameter I = 0,
              S = 1,
              B = 2;
    // Instantiate the module
    EXTENSION UUT (
        .Instr(Instr),
        .ImmControl(ImmControl),
        .ExtendedImm(ExtendedImm)
    );

    initial begin
        $dumpfile(
            "TB_EXTENDER.vcd"
        );
    
        $dumpvars(
            0, TB_EXTENSION
        );

        #2 Instr = 32'hFE420AE3;
        #0 ImmControl = 2;
        
        #1 Instr = 32'h0064A423;
        #0 ImmControl =1;


        #4 $finish;
    end
endmodule