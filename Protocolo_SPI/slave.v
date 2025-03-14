//Esteban Corrales Duarte - C02429
//Estos slaves tienen el mismo formato que el master hecho en clase, simplemente cambia de MOSI a MISO y que recibe el contador del master para saber cuando iniciar.
//El único cambio se encuentra en el bloque donde se recibe el spi_data y lo convertimos a un número hexadecimal.


//Slave 1:
module slave1 (
    input clk,
    input reset,
    input cs1M,
    input [15:0] MOSI,
    input spi_data,
    input [15:0] counter,
    output reg cs1S,
    output reg sclkS1,
    output reg [15:0] MISO
);


reg [2:0] state;
reg [15:0] contador;
reg [15:0] dato_recibido;
reg [3:0] bit_counter;   // Contador de bits recibidos (para saber cuando se recibieron los 16 bits).
reg clk_counter;   // Contador de ciclos de reloj  (Es necesario ya que el spi_data pasa su valor en binario cada 2 ciclos de reloj, traté de investigar la razón, pero esta fue la solución más fácil que se me ocurrió).
reg F;  //Cuando bit_counter sea F (16), lo haremos 0.





//En este bloque vamos a recibir mediante spi_data el valor entregado por MOSI, el cual es un valor binario, y lo convertimos a hexadecimal para enviarlo en el MISO.
always @(posedge clk or posedge reset) begin
    if (reset) begin
        bit_counter <= 4'd0; // Reiniciar el contador de bits en caso de reset
        clk_counter <= 0; // Reiniciar el contador de ciclos de reloj
        dato_recibido <= 16'd0;     // Reiniciar el registro dato_recibido
        F <= 1;   //Iniciamos con F = 1
    end else begin
        if (clk_counter == 1  && cs1M == 0 && F == 1) begin
            // Leer el spi_data cada 2 ciclos de reloj
            dato_recibido <= {dato_recibido[14:0], spi_data}; // Desplazar a la izquierda e introducir el nuevo bit 
            bit_counter <= bit_counter + 1;     // Incrementar el contador de bits
            clk_counter = 0;                    //Ya que estaba en 1, lo ponemos en cero.
            

            if (bit_counter == 4'd15) begin
                F <= 0;  //Lo ponemos en cero para ya parar todo este proceso.
            end
        end
        else begin
        clk_counter <= clk_counter + 1; // Incrementar el contador de ciclos de reloj
        end
    end
end



always @(posedge clk) begin
    if(reset) begin
        MISO <= 16'b0;
        contador <= 5'd16;
        cs1S <= 0;
        sclkS1 <= 1'b0; //porque nada puede empezar hasta el CS no baje
    end else if (counter == 0 && contador != 0 && cs1M == 0) begin
        case (state)
            0 : begin
                sclkS1 <= 1;
                state <= 1;
            end 
            1 :  begin
                sclkS1 <= 0;
                MISO <= dato_recibido[contador-1]; 
                contador <= contador -1;
                state <= 2;
            end
            2 : begin
                sclkS1 <= 1;
                if(contador > 0) begin
                    state <= 1;
                end else begin
                    contador <= 16;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
    else if(contador == 0) begin
        MISO <= 0;
        cs1S <= 1;
    end
end  
endmodule

//Slave 2:
module slave2 (
    input clk,
    input reset,
    input cs2M,
    input [15:0] datain,
    input spi_data,
    input [15:0] counter,
    output reg cs2S,
    output reg sclkS2,
    output reg [15:0] MISO
);


reg [2:0] state;
reg [15:0] contador;
reg [15:0] dato_obtenido;
reg [3:0] bit_contador;   // Contador de bits recibidos (para saber cuando se recibieron los 16 bits).
reg clk_contador;   // Contador de ciclos de reloj  (Es necesario ya que el spi_data pasa su valor en binario cada 2 ciclos de reloj, traté de investigar la razón, pero esta fue la solución más fácil que se me ocurrió).
reg FF;  //Cuando bit_counter sea F (16), lo haremos 0.





//En este bloque vamos a recibir mediante spi_data el valor entregado por MOSI, el cual es un valor binario, y lo convertimos a hexadecimal para enviarlo en el MISO.
always @(posedge clk or posedge reset) begin
    if (reset) begin
        bit_contador <= 4'd0; // Reiniciar el contador de bits en caso de reset
        clk_contador <= 0; // Reiniciar el contador de ciclos de reloj
        dato_obtenido <= 16'd0;     // Reiniciar el registro dato_obtenido
        FF <= 1;   //Iniciamos con FF = 1
    end else begin
        if (clk_contador == 1  && cs2M == 0 && FF == 1) begin
            // Leer el spi_data cada 2 ciclos de reloj
            dato_obtenido <= {dato_obtenido[14:0], spi_data}; // Desplazar a la izquierda e introducir el nuevo bit 
            bit_contador <= bit_contador + 1;     // Incrementar el contador de bits
            clk_contador = 0;                    //Ya que estaba en 1, lo ponemos en cero.
            

            if (bit_contador == 4'd15) begin
                FF <= 0;  //Lo ponemos en cero para ya parar todo este proceso.
            end
        end
        else begin
        clk_contador <= clk_contador + 1; // Incrementar el contador de ciclos de reloj
        end
    end
end



always @(posedge clk) begin
    if(reset) begin
        MISO <= 16'b0;
        contador <= 5'd16;
        cs2S <= 0;
        sclkS2 <= 1'b0; //porque nada puede empezar hasta el CS no baje
    end else if (counter == 0 && contador != 0 && cs2M == 0) begin
        case (state)
            0 : begin
                sclkS2 <= 1;
                state <= 1;
            end 
            1 :  begin
                sclkS2 <= 0;
                MISO <= dato_obtenido[contador-1]; 
                contador <= contador -1;
                state <= 2;
            end
            2 : begin
                sclkS2 <= 1;
                if(contador > 0) begin
                    state <= 1;
                end else begin
                    contador <= 16;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
    else if(contador == 0) begin
        MISO <= 0;
        cs2S <= 1;
    end
end  
endmodule
