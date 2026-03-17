`timescale 1ns / 1ps

module tb_fsm_moore_0110;

    reg clk;
    reg reset;
    reg in;
    wire out;

    // Instanciação da máquina de estados
    fsm_moore_0110 dut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // Geração do clock (período de 10ns)
    initial clk = 0;
    always #5 clk = ~clk;

    // Processo principal de estímulo
    initial begin
        // Inicialização
        $display("Tempo\tEntrada\tSaída");
        $monitor("%4t\t%b\t%b", $time, in, out);

        reset = 1;
        in = 0;
        #10;
        reset = 0;

        // Enviar a sequência: 0110110
        // Esperado: duas saídas '1' nos dois últimos zeros
        in = 0; #10; // S0 -> S1
        in = 1; #10; // S1 -> S2
        in = 1; #10; // S2 -> S3
        in = 0; #10; // S3 -> S4 → out = 1

        in = 1; #10; // S4 -> S2
        in = 1; #10; // S2 -> S3
        in = 0; #10; // S3 -> S4 → out = 1

        // Fim da simulação
        #20;
        $stop;
    end

endmodule
