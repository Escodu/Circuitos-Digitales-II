
`timescale 1ns/1ns

module tester(
    output reg clk, reset, activado, mdio_start, 
    output reg [31:0] t_data,
    input wr_stb, mdio_done,
    input [4:0] addr,
    input [15:0] wr_data
);
    

always begin
    #5 clk = !clk;
end

// Secuencia de prueba
initial begin
    // Inicialización de señales
    reset = 0;
    clk = 1;
    mdio_start = 0;
    t_data = 0;
    activado = 0;




    #25;
    t_data = 32'b01100011011011100111010001101110;

    #30;
    reset = 1;
    
    #60;
    activado = 1;


    mdio_start = 1;
    #20;
    
    mdio_start = 0;

    #780;    
    
    $finish;
end

endmodule