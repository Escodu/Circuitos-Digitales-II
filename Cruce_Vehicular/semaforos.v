// Esteban Corrales Duarte - CO2429

module semaforos (
    input clk,
    input enb,
    input reset,
    input [1:0] semaforo_A,
    input [1:0] semaforo_B,
    output reg Apeatonal,
    output reg Bpeatonal
);

always @(posedge clk) begin

    if(!enb)begin
    
    end

// Condiciones donde se controlará lo que deberá hacer cada semáforo según los distintos casos.

    else if (reset) begin
        
        Apeatonal = 0;
        Bpeatonal = 0;

    end

    else if ((semaforo_A == 2'b10 | semaforo_A == 2'b01)  & semaforo_B == 2'b00) begin
        
        Apeatonal = 0;
        Bpeatonal = 1;

    end

    else if ((semaforo_B == 2'b10 | semaforo_B == 2'b01)  & semaforo_A == 2'b00) begin
        
        Apeatonal = 1;
        Bpeatonal = 0;

    end
 
end














    
endmodule