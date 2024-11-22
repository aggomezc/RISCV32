`include "MAIN_DECODER.v"

module TB_MainDecoder;
    reg [6:0] opcode;
    reg [2:0] funct3;
    wire RegWrite;
    wire [1:0] ImmSrc;
    wire ALU_src;
    wire MemWrite;
    wire [1:0] Result_src;
    wire Branch;
    wire [2:0] ALU_op;
    wire Jump;

    Main_Decoder UUT(
        .opcode(opcode),
        .funct3(funct3),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALU_src(ALU_src),
        .MemWrite(MemWrite),
        .Result_src(Result_src),
        .Branch(Branch),
        .ALU_op(ALU_op),
        .Jump(Jump)
    );
    initial begin
        $dumpfile(
            "TB_MainDecoder.vcd"
        );
    
        $dumpvars(
            0, TB_MainDecoder
        );
        #1
        opcode = 7'b0100011;
        funct3 = 3'b000;
        #1
        opcode = 7'b0010011;
        funct3 = 3'b000;
        #2
        $finish;
    end
endmodule