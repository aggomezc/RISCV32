`include "ALU.v"

module TB_ALU ();
    reg [31:0] scrA;
    reg [31:0] scrB;
    reg [2:0] AluControl;
    wire [31:0] ALUresult;
    wire [2:0]Flag ;

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

        #1 scrA = 32'h200476;
        #1 scrB = 32'hFFFFFFFC;
        AluControl = 0;

        #1
        scrA = 32'h00000035;
        scrB = 32'h00000034;
        AluControl = 3'b100;
        #10 $finish;

    end
    
endmodule