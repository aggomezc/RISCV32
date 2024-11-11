`include "ALU.v"

module TB_ALU ();
    reg [31:0] scrA;
    reg [31:0] scrB;
    reg [2:0] AluControl;//Verily will the ALU only need to add
    wire [31:0] ALUresult;
    wire [1:0]Flag ;

    ALU uut(
        .scrA(scrA),
        .scrB(scrB),
        .AluControl(AluControl),
        .ALUresult(ALUresult),
        .Flag(Flag)
    );

    initial begin

    $dumpfile(
        "TB_ALU.vcd"
    );

    $dumpvars(
        0, TB_ALU
    );

        #1 scrA = 32'h2004;
        #1 scrB = 32'hFFFFFFFC;
        #1 AluControl = 0;
        #10 $finish;

    end
    
endmodule