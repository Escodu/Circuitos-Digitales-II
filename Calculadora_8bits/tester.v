// Esteban Corrales Duarte - C02429

`timescale 1ns/1ns

module tester (
    output reg clk,
    output reg rst,
    output reg enb,
    output reg [7:0] a,
    output reg [7:0] b,
    output reg [1:0] MODO,
    input [7:0] c
);
    
always begin
    #5 clk = !clk;
end

initial begin
    clk = 0;
    enb = 1;
    rst = 1;

    #5;

    rst = 0;
    
    //Sumas
    #10;
    MODO = 2'b00;
    a = 8'b00000001;
    b = 8'b00000001;

    #10; rst = 1; 

    #10;
    a = 8'b00001001;
    b = 8'b00000110;
    rst = 0;

    #10; rst = 1; 

    //Restas
    #10;
    MODO = 2'b01;
    a = 8'b00000011;
    b = 8'b00000001;
    rst = 0;

    #10; rst = 1; 

    #10;
    a = 8'b00011001;
    b = 8'b00000101;
    rst = 0;

    #10; rst = 1; 

    //Multiplicaciones
    #10;
    MODO = 2'b10;
    a = 8'b00000010;
    b = 8'b00000010;
    rst = 0;

    #10; rst = 1; 

    #10;
    a = 8'b00001001;
    b = 8'b00010001;
    rst = 0;

    #10; rst = 1; 

    //Left Shift
    #10;
    MODO = 2'b11;
    a = 8'b00000001;
    b = 8'b00000001;
    rst = 0;

    #10; rst = 1; 

    #10;
    a = 8'b00001000;
    b = 8'b00000010;
    rst = 0;

    #10; rst = 1; 

    #30;
    $finish;
end
    

endmodule