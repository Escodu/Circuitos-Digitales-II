`include "SPI.v"

module testbench (
    output reg clk,
    output reg reset,
    output reg [15:0] datain,
    input spi_cs1_l,
    input spi_cs2_l,
    input sclk1,
    input sclk2
);

SPI SPI (
    .clk(clk),
    .reset(reset),
    .datain(datain[15:0]),
    .spi_cs1_l(spi_cs1_l),
    .spi_cs2_l(spi_cs2_l),
    .sclk1(sclk1),
    .sclk2(sclk2)
);



always #5 clk = !clk;

initial begin
    reset = 1;
    clk = 0;
    datain = 0;
    #10;
    reset = 0;
    #10;
    datain = 16'hA569;
    #730;
    $finish;
end

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end

    
endmodule