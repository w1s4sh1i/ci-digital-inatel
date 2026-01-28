`timescale 1ns / 1ps

module tb_fsm_media();

    reg clk, reset, start, valid;
    reg [7:0] data_in;
    wire [7:0] media;
    wire done;

    fsm_media DUT (
        .clk(clk), .reset(reset),
        .start(start),.data_in(data_in), .valid(valid), 
        .media(media), .done(done)
    );

    // Clock de 10ns
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        reset = 1;
        start = 0;
        valid = 0;
        data_in = 0;

        #10 reset = 0;

        // Início da operação
        #10 start = 1; #10 start = 0;

        // Envio dos dados válidos
        @(posedge clk); data_in = 8'd10; valid = 1;
        @(posedge clk); valid = 0;
        @(posedge clk); data_in = 8'd20; valid = 1;
        @(posedge clk); valid = 0;
        @(posedge clk); data_in = 8'd30; valid = 1;
        @(posedge clk); valid = 0;
        @(posedge clk); data_in = 8'd40; valid = 1;
        @(posedge clk); valid = 0;

        // Espera pelo sinal de done
        wait (done == 1);

        // Exibe resultado
        #10;
        $display("Média calculada: %d", media);  // Esperado: (10+20+30+40)/4 = 25

        #20;
        $stop;
    end

endmodule
