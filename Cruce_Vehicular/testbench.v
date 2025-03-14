// Esteban Corrales Duarte - C02429

`include "semaforos.v"
`include "tester.v"

module testbench;

    wire clk, reset, enb, Apeatonal, Bpeatonal;
    wire  [1:0]semaforo_A;
    wire  [1:0]semaforo_B;


    semaforos DUT (
        .clk(clk),
        .reset(reset),
        .enb(enb),
        .semaforo_A(semaforo_A[1:0]),
        .semaforo_B(semaforo_B[1:0]),
        .Apeatonal(Apeatonal),
        .Bpeatonal(Bpeatonal)

    );

    tester prueba (
        .clk(clk),
        .reset(reset),
        .enb(enb),
        .semaforo_A(semaforo_A[1:0]),
        .semaforo_B(semaforo_B[1:0]),
        .Apeatonal(Apeatonal),
        .Bpeatonal(Bpeatonal)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

endmodule