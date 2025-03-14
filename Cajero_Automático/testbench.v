// Esteban Corrales Duarte - C02429

`include "cajero.v"
`include "tester.v"

module testbench;

    wire clk, reset, TARJETA_RECIBIDA, TIPO_DE_TARJETA, DIGITO_STB, TIPO_TRANS, MONTO_STB, ENTREGAR_DINERO, FONDOS_INSUFICIENTES;
    wire [15:0] PIN;
    wire [3:0] DIGITO;
    wire [31:0] MONTO;
    wire PIN_INCORRECTO, ADVERTENCIA, BLOQUEO, BALANCE_ACTUALIZADO, COMISION;


    cajero DUT (
        .clk(clk),
        .reset(reset),
        .TARJETA_RECIBIDA(TARJETA_RECIBIDA),
        .TIPO_DE_TARJETA(TIPO_DE_TARJETA),
        .DIGITO_STB(DIGITO_STB),
        .TIPO_TRANS(TIPO_TRANS),
        .MONTO_STB(MONTO_STB),
        .ENTREGAR_DINERO(ENTREGAR_DINERO),
        .FONDOS_INSUFICIENTES(FONDOS_INSUFICIENTES),
        .PIN_INCORRECTO(PIN_INCORRECTO),
        .ADVERTENCIA(ADVERTENCIA),
        .BLOQUEO(BLOQUEO),
        .BALANCE_ACTUALIZADO(BALANCE_ACTUALIZADO),
        .COMISION(COMISION),
        .PIN(PIN[15:0]),
        .DIGITO(DIGITO[3:0]),
        .MONTO(MONTO[31:0])
    );

    tester prueba (
        .clk(clk),
        .reset(reset),
        .TARJETA_RECIBIDA(TARJETA_RECIBIDA),
        .TIPO_DE_TARJETA(TIPO_DE_TARJETA),
        .DIGITO_STB(DIGITO_STB),
        .TIPO_TRANS(TIPO_TRANS),
        .MONTO_STB(MONTO_STB),
        .ENTREGAR_DINERO(ENTREGAR_DINERO),
        .FONDOS_INSUFICIENTES(FONDOS_INSUFICIENTES),
        .PIN_INCORRECTO(PIN_INCORRECTO),
        .ADVERTENCIA(ADVERTENCIA),
        .BLOQUEO(BLOQUEO),
        .BALANCE_ACTUALIZADO(BALANCE_ACTUALIZADO),
        .COMISION(COMISION),
        .PIN(PIN[15:0]),
        .DIGITO(DIGITO[3:0]),
        .MONTO(MONTO[31:0])
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

endmodule