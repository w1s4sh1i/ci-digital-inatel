`timescale 1ns / 1ps
module tb_mux16x1;
    reg  [15:0] tb_data_in;
    reg  [3:0]  tb_sel;
    wire        tb_out;
    integer     i;

    mux_16x1 dut (
        .out   (tb_out),
        .in  (tb_data_in),
        .sel   (tb_sel)
    );

    initial begin
        // Inicializar os sinais
        tb_data_in = 16'b0;
        tb_sel     = 4'b0;
        #10;

        for (i = 0; i < 16; i = i + 1) begin
            tb_sel = i;
            tb_data_in = (1 << i);  // Deslocar o bit de referência
            #10;
        end

        $finish;
    end
endmodule