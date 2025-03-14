`timescale 1ns/1ns

module generador (
    input clk,
    input activado,
    input reset,
    input mdio_start,
    input mdio_in,
    input [31:0] t_data,
    output reg data_rdy,
    output reg [15:0] rd_data,
    output reg mdio_oe,
    output reg [31:0] mdio_out,
    output reg mdc,
    output reg [31:0] contador,
    output prueba
);

reg [2:0] state;
reg temp;


always @(posedge clk or negedge clk)begin
    repeat (2)begin
        mdc <= clk;
        #10;
        mdc <= clk;
        
    end

end

always @(posedge clk ) begin
    if (!reset)begin
        data_rdy <= 0;
        rd_data <= 0;
        mdio_oe <= 0;
        mdio_out <= 0;
        contador <= 32;
        state = 0;
        temp = 0;
    end

    //Lectura
    if (t_data[29] == 1 && t_data[28] == 0 && activado == 1)begin
        if (contador != 0) begin
            case (state)
                0 :  begin
                    mdio_out <= t_data[contador-1]; 
                    contador <= contador -1;
                    state <= 1;                    
                    if (contador <= 16)begin
                        mdio_oe <= 0;
                        rd_data <= {rd_data[15:0], mdio_in};
                    end
                    else begin
                        mdio_oe <= 1;
                    end

                end
                1 : begin
                    if(contador > 0) begin
                        state <= 0;
                    end
                end
                default: state <= 0;
            endcase
        end
        else if (contador == 0 && temp == 0)begin
            data_rdy = 1;
            mdio_oe = 0;
            temp = 1;
            rd_data <= {rd_data[15:0], mdio_in};
            end
        
        else if (contador == 0) begin
            data_rdy = 0;
            mdio_oe = 0;
        end
    end

    //Escritura
    if (t_data[29] == 0 && t_data[28] == 1 && activado == 1)begin
        mdio_oe <= 1;
        if (contador != 0) begin
            case (state)
                0 :  begin
                    mdio_out <= t_data[contador-1]; 
                    contador <= contador -1;
                    state <= 1;
                end
                1 : begin
                    if(contador > 0) begin
                        state <= 0;
                    end else begin
                        contador <= 32;
                        state <= 0;
                    end
                end
                default: state <= 0;
            endcase
        end
        else if (contador == 0)begin
            mdio_oe <= 0;
            end
    end    
end

assign prueba = mdio_out;
endmodule


