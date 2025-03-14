//Esteban Corrales Duarte / C02429

module calculadora (
    input clk, rst, enb,
    input [7:0] a, // Entrada a de 8 bits
    input [7:0] b, // Entrada b de 8 bits
    input [1:0] MODO, // Modo de operación de 2 bits
    output reg [7:0] c // Salida c de 8 bits
);

always @(posedge clk) begin
    if (rst) begin
        c <= 8'b0; // Se restablece la salida en caso de reset
    end else begin
        if (enb) begin
            case (MODO)
                2'b00: c <= a + b; // Suma
                2'b01: c <= a - b; // Resta
                2'b10: c <= a * b; // Multiplicación
                2'b11: c <= a << b; // Desplazamiento izquierdo
                default: c <= 8'b0; // En caso de modo no válido, se asigna cero a la salida
            endcase
        end else begin
            c <= 8'b0; // Si no está habilitado, la salida es cero
        end
    end
end

endmodule