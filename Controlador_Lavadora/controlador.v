// Esteban Corrales Duarte - C02429

`timescale 1ns/1ns

module controlador (
    input clk,
    input INTRO_MONEDAS,
    input FINALIZAR_PAGO,
    input reset,
    output reg SECADO,
    output reg LAVADO,
    output reg LAVADO_PESADO,
    output reg INSUFICIENTE
);
    
reg [3:0] VERIFICACION_DE_PAGO;

always @(posedge clk) 
begin
    if(reset) begin
        VERIFICACION_DE_PAGO <= 0;
        LAVADO = 0;
        SECADO = 0;
        LAVADO_PESADO = 0;
        INSUFICIENTE = 0;
    end
    else if (INTRO_MONEDAS)
        VERIFICACION_DE_PAGO = VERIFICACION_DE_PAGO + 1;

    else if (FINALIZAR_PAGO)begin
        if (VERIFICACION_DE_PAGO == 4'b0011) begin
            SECADO = 1;
            #30;
        end
        else if (VERIFICACION_DE_PAGO == 4'b0100) begin
            LAVADO = 1;
            #30;
        end
        else if (VERIFICACION_DE_PAGO == 4'b1001) begin
            LAVADO_PESADO = 1;
            #30;
        end
        else begin
            INSUFICIENTE = 1;
            #10;
            INSUFICIENTE = 0;
        end
    end
end









endmodule