//Módulo hecho en clase por: Ing. Ana Eugenia Sánchez Villalobos

module master (
    input clk,
    input reset,
    input [15:0] datain,
    input [15:0] MISO,
    output reg cs1M,
    output reg cs2M,    
    output reg sclkM,
    output spi_data,
    output reg [15:0] MOSI,
    output reg [15:0] counter
);

reg [2:0] state;

always @(posedge clk) begin
    if(reset) begin
        MOSI <= 16'b0;
        counter <= 5'd16;
        cs1M <= 1;
        cs2M <= 1;
        sclkM <= 1'b0; //porque nada puede empezar hasta el CS no baje
    end else if (counter != 0) begin
        case (state)
            0 : begin
                cs1M <= 1;
                cs2M <= 1;
                sclkM <= 0;
                state <= 1;
            end 
            1 :  begin
                cs1M <= 0;
                cs2M <= 0;
                sclkM <= 1;
                MOSI <= datain[counter-1]; 
                counter <= counter -1;
                state <= 2;
            end
            2 : begin
                sclkM <= 0;
                if(counter > 0) begin
                    state <= 1;
                end else begin
                    counter <= 16;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
    else begin
        MOSI <= 0;
        sclkM <= 0;
        
    end
end

assign spi_data = MOSI;
    
endmodule