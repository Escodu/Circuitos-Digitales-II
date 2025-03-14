// Esteban Corrales Duarte - C02429

`timescale 1ns/1ns

module tester (
    output reg clk, reset, TARJETA_RECIBIDA, TIPO_DE_TARJETA, DIGITO_STB, TIPO_TRANS, MONTO_STB, ENTREGAR_DINERO, FONDOS_INSUFICIENTES,
    output reg [15:0] PIN,
    output reg [3:0] DIGITO,
    output reg [31:0] MONTO,
    input PIN_INCORRECTO, ADVERTENCIA, BLOQUEO, BALANCE_ACTUALIZADO, COMISION
);
    
always begin
    #5 clk = !clk;
end

initial begin
    clk = 0;
    PIN = 16'b1110001101101000;
    reset = 1;
    TARJETA_RECIBIDA = 0;
    TIPO_DE_TARJETA = 0;
    DIGITO_STB = 0;
    MONTO_STB = 0;
    ENTREGAR_DINERO = 0;
    FONDOS_INSUFICIENTES = 0;
    MONTO = 0;
    DIGITO = 0000;
    MONTO = 0;
    TIPO_TRANS = 0;
    #20;
    reset = 0;
    #10;


//INGRESO TARJETA
    TARJETA_RECIBIDA = 1;
    TIPO_DE_TARJETA = 1;
    #25;

//INGRESO PIN 1
    DIGITO = 4'b1110;
    #10;
    DIGITO_STB = 1;
    #10;
    DIGITO_STB = 0;
    DIGITO = 0;
    #10;
    DIGITO = 4'b0011;
    #10;
    DIGITO_STB = 1;
    #10;
    DIGITO_STB = 0;
    DIGITO = 0;
    #10;
    DIGITO = 4'b0110;
    #10;
    DIGITO_STB = 1;
    #10;
    DIGITO_STB = 0;
    DIGITO = 0;
    #10;
    DIGITO = 4'b1000;
    #10;
    DIGITO_STB = 1;
    #10;
    DIGITO_STB = 0;
    #20;

//Tipo de Transacción
    TIPO_TRANS = 0;
    MONTO = 0000000000001111;
    #10;
    MONTO_STB = 1;

    #80;



    reset = 1;
    #70;
    $finish;
end
    

endmodule