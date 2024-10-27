reg [7:0] array4 [0:3];
reg [7:0] array7 [6:0];
reg [7:0] array12 [11:0];

integer i;

initial begin
    $readmemb("data.txt", array4);
    $readmemb("data.txt", array7, 2, 5);
    $readmemb("data.txt", array12);

    for (i = 0; i < 4; i = i+1)
        $display("array4[%0d] = %b", i, array4[i]);

    $display("=========================");

    for (i = 0; i < 7; i = i+1)
        $display("array7[%0d] = %b", i, array7[i]);

    $display("=========================");

    for (i = 0; i < 12; i = i+1)
        $display("array12[%0d] = %b", i, array12[i]);
end