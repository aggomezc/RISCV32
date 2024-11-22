`include "DYNAMIC_MEM.v"
module tb_DynamicMemory;

    // Parameters
    parameter ADDR_WIDTH = 10; // 1024 bytes = 2^10
    parameter DATA_WIDTH = 32;

    // Inputs
    reg CLK;
    reg WE;
    reg [2:0] funct3;
    reg [31:0] ADDRESS;
    reg [31:0] WRITE_DATA;

    // Outputs
    wire [31:0] READ_DATA;

    // Instantiate the DynamicMemory module
    DynamicMemory uut (
        .CLK(CLK),
        .WE(WE),
        .funct3(funct3),
        .ADDRESS(ADDRESS),
        .WRITE_DATA(WRITE_DATA),
        .READ_DATA(READ_DATA)
    );

    // Clock generation
    always #5 CLK = ~CLK; // 10 ns clock period

    // Test procedure
    initial begin

        $dumpfile(
            "tb_DynamicMemory.vcd"
        );
    
        $dumpvars(
            0, tb_DynamicMemory
        );
        // Initialize inputs
        CLK = 0;
        WE = 0;
        funct3 = 3'b000; // Default to store byte
        ADDRESS = 0;
        WRITE_DATA = 0;

        // Test 1: Write a word to memory
        @(posedge CLK);
        WE = 1;
        funct3 = 3'b010; // Store word
        ADDRESS = 0; // Write to address 0
        WRITE_DATA = 32'hAABBCCDD; // Data to write
        @(posedge CLK);
        WE = 0; // Disable write

        // Test 2: Read back the word
        @(posedge CLK);
        ADDRESS = 0; // Read from the same address
        #1; // Small delay to allow READ_DATA to settle
        $display("Read Data (Word from Address 0): %h", READ_DATA);

        // Test 3: Write a byte to memory
        @(posedge CLK);
        WE = 1;
        funct3 = 3'b000; // Store byte
        ADDRESS = 1; // Write to address 1
        WRITE_DATA = 32'hFF; // Data to write (only the least significant byte will be used)
        @(posedge CLK);
        WE = 0; // Disable write

        // Test 4: Read back the byte
        @(posedge CLK);
        ADDRESS = 1; // Read from address 1
        #1; // Small delay to allow READ_DATA to settle
        $display("Read Data (Byte from Address 1): %h", READ_DATA[7:0]);

        // Test 5: Write another word to a different address
        @(posedge CLK);
        WE = 1;
        funct3 = 3'b010; // Store word
        ADDRESS = 4; // Write to address 4
        WRITE_DATA = 32'h11223344; // Data to write
        @(posedge CLK);
        WE = 0; // Disable write

        // Test 6: Read back the new word
        @(posedge CLK);
        ADDRESS = 4; // Read from address 4
        #1; // Small delay to allow READ_DATA to settle
        $display("Read Data (Word from Address 4): %h", READ_DATA);

        // Test 7: Write a byte to another address
        @(posedge CLK);
        WE = 1;
        funct3 = 3'b000; // Store byte
        ADDRESS = 5; // Write to address 5
        WRITE_DATA = 32'hAA; // Data to write (only the least significant byte will be used)
        @(posedge CLK);
        WE = 0; // Disable write

        // Test 8: Read back the byte
        @(posedge CLK);
        ADDRESS = 5; // Read from address 5
        #1; // Small delay to allow READ_DATA to settle
        $display("Read Data (Byte from Address 5): %h", READ_DATA[7:0]);

        // Finish simulation
        $finish;
    end

endmodule