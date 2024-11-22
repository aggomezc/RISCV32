module DynamicMemory(
    input CLK,
    input WE,
    input [2:0] funct3,
    input [31:0] ADDRESS,
    input [31:0] WRITE_DATA,  
    output reg [31:0] READ_DATA
    
    //Lectura asíncrona y escritura sincrona
);
    parameter sw = 2;
    parameter sb = 0;
    reg [7:0] MEMORY_ARRAY [1024:0];

task print_memory;
    reg[1024:0] file;
    integer i;
    file = $fopen("MemDUMP.txt", "w");
    if (file == 0) begin
        $display("Error opening file");
        $finish;
    end

    $fwrite(file, "Memory contents:\n");
    for (i = 0; i < 1024; i++) begin
        $fwrite(file, "%h\n", MEMORY_ARRAY[i]);
    end

    $fclose(file);
endtask
    //Sdifferentiate that
    always @(posedge CLK ) begin
        if (WE && funct3 == sw) begin //If we have a store word
            MEMORY_ARRAY[ADDRESS] <=   WRITE_DATA[31:24];
            MEMORY_ARRAY[ADDRESS+1] <= WRITE_DATA[23:16];
            MEMORY_ARRAY[ADDRESS+2] <= WRITE_DATA[15:8];
            MEMORY_ARRAY[ADDRESS+3] <= WRITE_DATA[7:0];
        end
        // if we have a store byte
        else if (WE && funct3 == sb) begin
            MEMORY_ARRAY[ADDRESS] <= WRITE_DATA[7:0]; //CRITICAL
            //I DID THIS CONSIDERING CONSIDERING A BIG ENDIAN STRUCTURE

        end
    end
    //lectura asincrona
    always @(*) begin //we will always have a load word situation
        READ_DATA[31:24] = MEMORY_ARRAY[ADDRESS];
        READ_DATA[23:16] = MEMORY_ARRAY[ADDRESS+1];
        READ_DATA[15:8] = MEMORY_ARRAY[ADDRESS+2];
        READ_DATA[7:0] = MEMORY_ARRAY[ADDRESS+3];
    end

endmodule