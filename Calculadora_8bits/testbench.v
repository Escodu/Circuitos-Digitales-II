// Esteban Corrales Duarte - C02429

`include "synth.v"
`include "tester.v"
`include "cmos_cells_delay.v"


module testbench;

    wire clk, rst, enb;
    wire  [7:0]a;
    wire  [7:0]b;
    wire  [7:0]c;
    wire  [1:0]MODO;

    calculadora DUT (
        .clk(clk),
        .rst(rst),
        .enb(enb),
        .a(a[7:0]),
        .b(b[7:0]),
        .c(c[7:0]),
        .MODO(MODO[1:0])
    );

    tester prueba (
        .clk(clk),
        .rst(rst),
        .enb(enb),
        .a(a[7:0]),
        .b(b[7:0]),
        .c(c[7:0]),
        .MODO(MODO[1:0])
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

endmodule