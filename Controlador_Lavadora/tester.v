//Esteban Corrales Duarte - C02429


`timescale 1ns/1ns

module tester (
    output reg clk,
    output reg INTRO_MONEDAS,
    output reg FINALIZAR_PAGO,
    output reg reset,
    input SECADO,
    input LAVADO,
    input LAVADO_PESADO,
    input INSUFICIENTE
);
    
always begin
    #5 clk = !clk;
end

initial begin

    //Reinicio
    clk = 0;
    reset = 1;
    FINALIZAR_PAGO = 0;
    INTRO_MONEDAS = 0;

    #10
    reset = 0;

    //Introducción monedas para insuficiente
    INTRO_MONEDAS = 1;

    #15

    INTRO_MONEDAS = 0;
    FINALIZAR_PAGO = 1;

    #10 FINALIZAR_PAGO = 0; 

    reset = 1;
    
    #10
    reset = 0;

    //Introducción monedas para lavado
    INTRO_MONEDAS = 1;

    #40

    INTRO_MONEDAS = 0;
    FINALIZAR_PAGO = 1;

    #10 FINALIZAR_PAGO = 0; 

    #20

    reset = 1;
    
    #10
    reset = 0;

    //Introducción monedas para lavado pesado
    INTRO_MONEDAS = 1;

    #90

    INTRO_MONEDAS = 0;
    FINALIZAR_PAGO = 1;

    #10 FINALIZAR_PAGO = 0; 
    
    #20 

    reset = 1;
    
    #10
    reset = 0;

    //Introducción monedas para secado
    INTRO_MONEDAS = 1;

    #30

    INTRO_MONEDAS = 0;
    FINALIZAR_PAGO = 1;

    #10 FINALIZAR_PAGO = 0; 

    #20

    reset = 1;
    
    #10;

    $finish;

end

endmodule