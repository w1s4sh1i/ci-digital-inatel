`timescale 1ns/1ps
`include "mux_2x1.v"

module mux_2x1_tb;

    //reg a, b, sel; // 1ª Parte
    reg [1:0]D, sel;
    wire y;

   // 1ª Parte do exercicio 2
   // mux2 mux_2x1_tb(
   //     .a(a), .b(b), .sel(sel),
   //     .y(y)
   // );

   mux3 upp(
    .D(D), .sel(sel), 
    .y(y)
   );

    // 1º Parte
    //always begin #1 a = !a; end
    //always begin #2 b = !b; end

    always begin #1 D[0] = !D[0]; end
    always begin #2 D[1] = !D[1]; end
    always begin #4 sel = !sel; end

    initial begin
      $dumpfile("mux_2x1_tb.vcd");
      $dumpvars(0, mux_2x1_tb);
      // se 1 -> a, 0 -> b
      sel = 1'b0;
      //a = 1'b0;
      //b = 1'b0;
      D = 2'd0;
      #10;
      $finish;

    end

endmodule