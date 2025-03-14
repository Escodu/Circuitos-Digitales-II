//Esteban Corrales Duarte - C02429

/*En este módulo lo que se busca es tomar el protocolo SPI como un solo bloque, por lo que instanciamos el master y los 2 slaves a utilizar,
además usamos 3 assign con lógica correspondiente para crear la señal completa del sclk y del spi_cs_l 1  y 2  */

`include "master.v"
`include "slave.v"

module SPI (
    input clk,
    input reset,
    input [15:0] datain,
    output wire spi_cs1_l,
    output wire spi_cs2_l,
    output wire sclk1,
    output wire sclk2,
    output wire [15:0] counter1
);

wire [15:0] MOSI;
wire [15:0] MISO;
wire [15:0] counter;
wire spi_data;

assign spi_cs1_l = cs1M | cs1S;
assign spi_cs2_l = cs2M | cs2S;
assign sclk1 = sclkM | sclkS1;
assign sclk2 = sclkM | sclkS2;

master master (
    .clk(clk),
    .reset(reset),
    .datain(datain[15:0]),
    .cs1M(cs1M),
    .cs2M(cs2M),
    .sclkM(sclkM),
    .spi_data(spi_data),
    .counter(counter1[15:0]),
    .MISO(MISO[15:0]),
    .MOSI(MOSI[15:0])
);

slave1 slave1 (
    .clk(clk),
    .reset(reset),
    .MOSI(MOSI[15:0]),
    .cs1M(cs1M),
    .cs1S(cs1S),
    .sclkS1(sclkS1),
    .spi_data(spi_data),
    .counter(counter1[15:0]),
    .MISO(MISO[15:0])
);

slave2 slave2 (
    .clk(clk),
    .reset(reset),
    .datain(datain[15:0]),
    .cs2M(cs2M),
    .cs2S(cs2S),
    .sclkS2(sclkS2),
    .spi_data(spi_data),
    .counter(counter1[15:0]),
    .MISO(MISO[15:0])
);

endmodule
