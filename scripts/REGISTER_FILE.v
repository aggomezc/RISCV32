//`timescale 1ns / 1ps

module REGISTERFILE ( 
    A1, //dir reg 1
    A2, //dir reg 2
    A3, ////dir reg to write
    WD3, //write data
    RD1, // data read from reg 1
    RD2, // data read from reg 2
    EN,  //// ENABLE read
    CLK //reloj GLOBAL
);
//ocupamos un reloj global
    input [4:0] A1, A2, A3;
    input CLK;
    input WD3, EN;
    output [31:0] RD1, RD2;
    //para no sumarle nada a valores XX
    integer i;
    initial begin
		REGISTER_ARRAY[31] = 0;
        for(i=0; i<31; i = i+1) begin
            REGISTER_ARRAY[i]=i+100;
        end
    end
    //SW utiliza como funct3

    reg [31:0] REGISTER_ARRAY [31:0];
    //LECTURA ASINCRONA
    assign RD1 = REGISTER_ARRAY[A1];
    assign RD2 = REGISTER_ARRAY[A2];

    //escritura sincrona
    always @(posedge CLK ) begin

        if (EN && (A3 != 0)) begin    //x0 est 0
            REGISTER_ARRAY[A3] <= WD3;
        end
    
    end
endmodule