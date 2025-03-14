//Esteban Corrales Duarte - C02429

`timescale 1ns/1ns

module cajero (
    input clk, reset, TARJETA_RECIBIDA, TIPO_DE_TARJETA, DIGITO_STB, TIPO_TRANS, MONTO_STB, 
    input [15:0] PIN,
    input [3:0] DIGITO,
    input [15:0] MONTO,
    output reg PIN_INCORRECTO, ADVERTENCIA, BLOQUEO, ENTREGAR_DINERO, BALANCE_ACTUALIZADO, FONDOS_INSUFICIENTES, COMISION
);
    
reg [63:0] BALANCE;
reg [2:0] COMP;
reg [2:0] CONTAR;
reg [1:0] INTENTO;

always @(posedge clk) begin
    if (reset) begin
        PIN_INCORRECTO <= 0;
        ADVERTENCIA <= 0;
        BLOQUEO <= 0;
        BALANCE_ACTUALIZADO <= 0;
        COMP <= 0;
        CONTAR <= 0;
        COMISION <= 0;
        ENTREGAR_DINERO = 0;
        FONDOS_INSUFICIENTES = 0;
        INTENTO = 0;
        BALANCE <= 0000000000000000000000000000000000000000000000000000000000001111; //60 ceros y 4 unos, esto para probar si se pasa en un retiro mayor
    end else begin
        
    end
end

always @(*) begin

    // Tarjeta otro banco porque se activa comisión
    if (TARJETA_RECIBIDA && TIPO_DE_TARJETA) begin
        COMISION <= 1;

        //Si el pin fue correcto, se elige entre DEPOSITO o RETIRO
        if (COMP == 3'b100 && MONTO_STB) begin 
            if (TIPO_TRANS) begin
                if (MONTO < BALANCE) begin
                    BALANCE_ACTUALIZADO = 1;
                    BALANCE = BALANCE - MONTO;
                    ENTREGAR_DINERO = 1;
                end
                else
                    FONDOS_INSUFICIENTES = 1;
            end

            if (!TIPO_TRANS) begin
                BALANCE = BALANCE + MONTO;
                BALANCE_ACTUALIZADO = 1;
            end
        end


        //Comprobación del pin de 4 en 4
        if (DIGITO_STB && CONTAR != 4) begin
            CONTAR = CONTAR + 1;
            for (integer i = 0; i < 4; i = i + 1) begin
                if (PIN[i*4 +: 4] == DIGITO) begin
                    COMP = COMP + 1;
                end
            end
        end

        //Si el pin fue incorrecto, sume 1 a intentos
        if (DIGITO_STB == 1 && COMP != 4 && CONTAR == 4 && INTENTO < 2) begin 
            INTENTO = INTENTO + 1;
            PIN_INCORRECTO = 1;
            #10;
            COMP = 0;
            CONTAR = 0;
            PIN_INCORRECTO = 0;
        end

        //Si hay 2 intentos, active advertencia
        if (INTENTO == 2)begin
            ADVERTENCIA = 1;
        end

        //Si hubo un tercer error con 2 intentos ya hechos
        if (COMP != 4 && CONTAR == 4 && INTENTO == 2)begin
            PIN_INCORRECTO = 1;
            #10;
            ADVERTENCIA = 1;
            INTENTO = INTENTO + 1;
            COMP = 0;
            CONTAR = 0;
        end

        //Active bloqueo
        if (INTENTO == 3)begin
            ADVERTENCIA = 0;
            BLOQUEO = 1;
        end

    end
    
    //Tarjeta BCR, aquí la única diferencia con la parte superior, es que no se activa comisión, por lo que no hay comentarios en cada parte del código porque serían los mismos que arriba
    if (TARJETA_RECIBIDA && !TIPO_DE_TARJETA) begin
        COMISION <= 0;

        if (COMP == 3'b100 && MONTO_STB) begin 
            if (TIPO_TRANS) begin
                if (MONTO < BALANCE) begin
                    BALANCE_ACTUALIZADO = 1;
                    BALANCE = BALANCE - MONTO;
                    ENTREGAR_DINERO = 1;
                end
                else
                    FONDOS_INSUFICIENTES = 1;
            end

            if (!TIPO_TRANS) begin
                BALANCE = BALANCE + MONTO;
                BALANCE_ACTUALIZADO = 1;
            end
        end

        if (DIGITO_STB && CONTAR != 4) begin
            CONTAR = CONTAR + 1;
            for (integer i = 0; i < 4; i = i + 1) begin
                if (PIN[i*4 +: 4] == DIGITO) begin
                    COMP = COMP + 1;
                end
            end
        end

        if (DIGITO_STB == 1 && COMP != 4 && CONTAR == 4 && INTENTO < 2) begin 
            INTENTO = INTENTO + 1;
            PIN_INCORRECTO = 1;
            #10;
            COMP = 0;
            CONTAR = 0;
            PIN_INCORRECTO = 0;
        end

        if (INTENTO == 2)begin
            ADVERTENCIA = 1;
        end

        if (COMP != 4 && CONTAR == 4 && INTENTO == 2)begin
            PIN_INCORRECTO = 1;
            #10;
            ADVERTENCIA = 1;
            INTENTO = INTENTO + 1;
            COMP = 0;
            CONTAR = 0;
        end

        if (INTENTO == 3)begin
            ADVERTENCIA = 0;
            BLOQUEO = 1;
        end
end
end
endmodule