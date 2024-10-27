module DynamicMemory(
    input CLK,
    input WE,
    input [1:0] funct3,
    input [31:0] ADDRESS,
    input [31:0] WRITE_DATA,  
    output [31:0] READ_DATA
    //Lectura asíncrona y escritura sincrona
);
    parameter sw = 2;
    parameter sb = 0;
    reg [7:0] MEMORY_ARRAY [1024:0];

    //Sdifferentiate that
    always @(posedge CLK ) begin
        if (WE && funct3 == sw) begin //If we have a store word
            MEMORY_ARRAY[ADDRESS] <=   WRITE_DATA[31:24];
            MEMORY_ARRAY[ADDRESS+1] <= WRITE_DATA[23:16];
            MEMORY_ARRAY[ADDRESS+2] <= WRITE_DATA[15:8];
            MEMORY_ARRAY[ADDRESS+3] <= WRITE_DATA[7:0];
        end
        // if we have a store byte
        if (WE && funct3 == sb) begin
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

    end

endmodule