`include "ALU_DECODE.v"

module ALU_DECODE_TB ();

    reg [2:0] ALUOP;
    reg [2:0] funct3;
    wire [2:0] ALU_Control;
    
    ALU_DECODE UUT(
        .ALUOP(ALUOP),
        .funct3(funct3),
        .ALU_Control(ALU_Control)
    );

    initial begin
        $dumpfile(
            "ALU_DECODE_TB.vcd"
        );
    
        $dumpvars(
            0, ALU_DECODE_TB
        );
        ALUOP = 3'b100;
        funct3 = 3'b001;

        #1 $finish;
    end
endmodule