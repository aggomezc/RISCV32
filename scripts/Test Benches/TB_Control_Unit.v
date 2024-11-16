`include "CONTROL_UNIT.v"

module Control_Unit_TB;
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [2:0] ALU_flags;

    wire RegWrite;
    wire [1:0] ImmSrc;
    wire ALU_src;
    wire MemWrite;
    wire [1:0] Result_src;
    wire Branch;
    wire [2:0] ALU_op;
    wire Jump;
    wire PC_Src;


    Control_Unit UUT(
        .opcode(opcode),
        .funct3(funct3),
        .ALU_flags(ALU_flags),

        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALU_src(ALU_src),
        .MemWrite(MemWrite),
        .Result_src(Result_src),
        .PC_Src(PC_Src)
    );


    initial begin
        $dumpfile(
            "Control_Unit_TB.vcd"
        );
    
        $dumpvars(
            0, Control_Unit_TB
        );

    // Stimulus for I-type instruction (ADDI)
    opcode = 7'b0010011; // I-type opcode
    funct3 = 3'b000;     // ADDI funct3
    ALU_flags = 3'b100;
    #10; // Wait for some time

    // Stimulus for Load instruction (LW)
    opcode = 7'b0000011; // Load opcode
    funct3 = 3'b010;     // LW funct3
    ALU_flags = 3'b000;
    #10; // Wait for some time

    // Stimulus for Store instruction (SW)
    opcode = 7'b0100011; // Store opcode
    funct3 = 3'b010;     // SW funct3
    ALU_flags = 3'b010;
    #10; // Wait for some time

    // Stimulus for Branch instruction (BNE)
    opcode = 7'b1100111; // Branch opcode
    funct3 = 3'b001;     // BEQ funct3
    ALU_flags = 3'b001;
    #10; // Wait for some time

        // Stimulus for Branch instruction (BGE)
    opcode = 7'b1100111; // Branch opcode
    funct3 = 3'b101;     // BEQ funct3
    ALU_flags = 3'b010;
    #10; // Wait for some time
    end
    
endmodule