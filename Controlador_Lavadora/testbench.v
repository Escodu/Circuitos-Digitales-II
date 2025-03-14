//Esteban Corrales Duarte - C02429

`include "controlador.v"
`include "tester.v"

module testbench;

    wire clk, reset, INTRO_MONEDAS, FINALIZAR_PAGO, SECADO, LAVADO, LAVADO_PESADO, INSUFICIENTE;


    controlador DUT (
        .clk(clk),
        .INTRO_MONEDAS(INTRO_MONEDAS),
        .FINALIZAR_PAGO(FINALIZAR_PAGO),
        .reset(reset),
        .SECADO(SECADO),
        .LAVADO(LAVADO),
        .LAVADO_PESADO(LAVADO_PESADO),
        .INSUFICIENTE(INSUFICIENTE)

    );

    tester prueba (
        .clk(clk),
        .INTRO_MONEDAS(INTRO_MONEDAS),
        .FINALIZAR_PAGO(FINALIZAR_PAGO),
        .reset(reset),
        .SECADO(SECADO),
        .LAVADO(LAVADO),
        .LAVADO_PESADO(LAVADO_PESADO),
        .INSUFICIENTE(INSUFICIENTE)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end












endmodule