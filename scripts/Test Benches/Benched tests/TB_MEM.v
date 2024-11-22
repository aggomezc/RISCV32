`include "INSTR_MEM.v"

module INSTR_MEM_TB;
    reg clk;
    reg [31:0] PC;
    wire [31:0] Inst;

    MEM UUT(
        .CLK(clk), 
        .PC(PC), 
        .Instr(Inst)
    );

    initial begin
        $dumpfile(
            "MEM_TEST.vcd"
        );
    
        $dumpvars(
            0, INSTR_MEM_TB
        );
        clk = 0;
    

        #1 PC = 1;
        #1 clk = ~clk; 
        #1 clk = ~clk;

        #1 PC = 2;
        #1 clk = ~clk; 
        #1 clk = ~clk;
        
        #1 PC = 3;
        #1 clk = ~clk;
        #1 clk = ~clk;
        #1 $finish;
    end


    // Make the clock tick at a 10ns interval
    //always #5 clk = ~clk;
endmodule
