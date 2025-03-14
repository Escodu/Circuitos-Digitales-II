module receptor (
    input mdc,
    input mdio_oe,
    input reset,
    input prueba,
    input [31:0] contador,
    input [31:0] mdio_out,
    input [15:0] rd_data,
    output reg [4:0] addr,
    output reg [15:0] wr_data,
    output reg mdio_done, wr_stb, mdio_in
);

reg [15:0] sebas;
reg [15:0] ana;
reg temp1;

always @(posedge mdc) begin
    if(!reset) begin
        addr <= 0;
        wr_data <= 0;
        mdio_done <= 0; 
        wr_stb <= 0;
        mdio_in <= 0;
        sebas <= 0;
        ana <= 0;
        temp1 <= 0;
    end

    if (contador <= 26 && 22 <= contador) begin
        ana <= {ana[15:0], prueba};
    end

    if (contador <= 21 && 17 <= contador) begin
        sebas <= {sebas[15:0], prueba};


    end


    if (contador <= 16 && !mdio_oe) begin
        mdio_in <= sebas[contador];
        addr <= ana[contador];
    end

    if (contador == 0 && temp1 == 0) begin
        mdio_done = 1;
        wr_stb = 1;
        wr_data = 16'b0100010101000110;
        temp1 = 1;
    end

    else if(contador == 0) begin
        mdio_done = 0;
        wr_stb = 0;
        wr_data = 0;
    end





end






endmodule