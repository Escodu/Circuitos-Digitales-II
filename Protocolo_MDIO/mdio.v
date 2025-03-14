`include "generador.v"
`include "receptor.v"

module mdio (
    input clk, reset, activado, mdio_start, 
    input [31:0] t_data,
    output wire wr_stb, mdio_done,
    output wire [4:0] addr,
    output wire [15:0] wr_data

);

wire mdio_in;
wire [31:0] contador;
wire [31:0] mdio_out;
wire mdio_oe;
wire mdc;
wire [15:0] rd_data;
wire prueba;

generador generador (
    .clk(clk),
    .reset(reset),
    .activado(activado),
    .prueba(prueba),
    .mdc(mdc),
    .mdio_in(mdio_in),
    .mdio_start(mdio_start),
    .data_rdy(data_rdy),
    .mdio_oe(mdio_oe),
    .mdio_out(mdio_out[31:0]),
    .t_data(t_data[31:0]),
    .rd_data(rd_data[15:0]),
    .contador(contador)
);

receptor receptor (
    .mdc(mdc),
    .mdio_oe(mdio_oe),
    .reset(reset),
    .prueba(prueba),
    .contador(contador[31:0]),
    .mdio_out(mdio_out[31:0]),
    .rd_data(rd_data[15:0]),
    .addr(addr[4:0]),
    .wr_data(wr_data[15:0]),
    .mdio_done(mdio_done),
    .wr_stb(wr_stb),
    .mdio_in(mdio_in)   
);


endmodule