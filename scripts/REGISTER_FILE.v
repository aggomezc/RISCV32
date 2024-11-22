//`timescale 1ns / 1ps

module REGISTERFILE ( 
    CLK,
    A1, //dir reg 1
    A2, //dir reg 2
    A3, ////dir reg to write
    WD3, //write data
    RD1, // data read from reg 1
    RD2, // data read from reg 2
    EN,  //// ENABLE read
);
//ocupamos un reloj global
    input [4:0] A1, A2, A3;
    input CLK;
    input [31:0] WD3;
    input EN;
    output reg [31:0] RD1, RD2;
    integer i;
    initial begin
        for(i=1; i<=31; i = i+1) begin
            REGISTER_ARRAY[i]=i+100;
        end
        REGISTER_ARRAY[0] = 0;
    end
    //SW utiliza como funct3
    

    reg [31:0] REGISTER_ARRAY [31:0];
    //LECTURA ASINCRONA
    always @(*) begin
        RD1 = REGISTER_ARRAY[A1];
        RD2 = REGISTER_ARRAY[A2];
    end




    //escritura sincrona
    always @(posedge CLK ) begin
        if (EN && (A3 != 5'b00000)) begin    //x0 est 0
            REGISTER_ARRAY[A3] <= WD3;
        end
    
    end
endmodule