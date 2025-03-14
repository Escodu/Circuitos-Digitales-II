`include "mdio.v"
`include "tester.v"

module testbench;
    wire clk, reset, activado, mdio_start, wr_stb, mdio_done;
    wire [31:0] t_data;
    wire [4:0] addr;
    wire [15:0] wr_data;
    wire mdio_in;


    mdio DUT (
        .clk(clk),
        .reset(reset),
        .activado(activado),
        .t_data(t_data[31:0]),
        .wr_stb(wr_stb),
        .mdio_done(mdio_done),
        .mdio_start(mdio_start),
        .addr(addr[4:0] ),
        .wr_data(wr_data[15:0])
    );

    tester prueba (
        .clk(clk),
        .reset(reset),
        .activado(activado),
        .t_data(t_data[31:0]),
        .wr_stb(wr_stb),
        .mdio_done(mdio_done),
        .mdio_start(mdio_start),
        .addr(addr[4:0] ),
        .wr_data(wr_data[15:0])
        
    );






    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

endmodule
