`include "BranchEncoder.v"


module TB_BranchEncoder;
    // Declare inputs as reg and outputs as wire
    //Entradas: Branch: si la instrucción actual es un branch ejecutará
    
    reg Branch;
    reg [2:0] funct3;
    wire Encoded_Branch;

    // Instantiate the module under test (MUT)
    BranchEncoder uut (
        .Branch(Branch),
        .funct3(funct3),
        .Encoded_Branch(Encoded_Branch)
    );

    // Test sequence
    initial begin
        // Enable waveform dumping
        $dumpfile("BranchEncoder.vcd"); // Specify the output VCD file
        $dumpvars(0, TB_BranchEncoder); // Dump all variables in this module
        

        // Initialize inputs
        Branch = 0; funct3 = 3'b000; #10; // Branch disabled
        Branch = 1; funct3 = 3'b101; #10; // BGE test case
        Branch = 1; funct3 = 3'b001; #10; // BNE test case
        Branch = 1; funct3 = 3'b010; #10; // Undefined funct3
        Branch = 0; funct3 = 3'b101; #10; // Branch disabled, funct3 irrelevant
        Branch = 1; funct3 = 3'b111; #10; // Undefined funct3
        $finish; // End simulation
    end
endmodule
