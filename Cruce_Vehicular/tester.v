// Esteban Corrales Duarte - C02429

`timescale 1ns/1ns

module tester (
    output reg clk,
    output reg reset,
    output reg enb,
    output reg [1:0] semaforo_A,
    output reg [1:0] semaforo_B,
    input Apeatonal,
    input Bpeatonal
);
    
always begin
    #5 clk = !clk;
end

initial begin
    clk = 0;
    enb = 1;
    reset = 1;
    #10;


//Estado reset, ambos semaforos peatonales en rojo, Semaforo A en verde
    semaforo_A = 2'b10;
    semaforo_B = 2'b00;
    #25;

//Estado semaforo peatonal B en verde
    reset = 0;
    #20;

//Semaforo A en amarillo
    semaforo_A = 2'b01;
    #10;


//Estado semaforo A en rojo, peatonal A en verde, Semaforo B en verde, peatonal B en rojo
    semaforo_A = 2'b00;
    semaforo_B = 2'b10;

    #25;

//Semaforo B en amarillo
    semaforo_B = 2'b01;
    #15;

//Estado reset, ambos semaforos peatonales en rojo, Semaforo A en verde
    semaforo_A = 2'b10;
    semaforo_B = 2'b00;
    reset = 1;

    #30;
    $finish;
end
    

endmodule