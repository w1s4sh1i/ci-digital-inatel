/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-101
Type: Testbench
Data: octuber, 29 2025
*/

`timescale 1 ns / 1 ps;
module mux_2x1_tb;

    localparam DELAY = 10;
    reg [1:0]D, sel;
    wire y;

	/* 1ª Parte do exercicio 2
   		mux2 mux_2x1_tb(
        	.a(a), .b(b), .sel(sel),
      		.y(y)
   		);
	*/
   mux3 upp(
		.D(D), .sel(sel), 
		.y(y)
   );

    /* 1º Parte
    	always begin #1 a = !a; end
    	always begin #2 b = !b; end
	*/
	
    always #1 D[0] = !D[0];
    always #2 D[1] = !D[1];
    always #4  sel = !sel;

    initial begin
      
		// Specify the VCD file name
		$dumpfile("CIDI-SD122-A101-1.vcd"); 
        $dumpvars(0, mux_2x1_tb);
		
		$display("|Select	|Y	|");
		$monitor("|%b |%b |", sel, y);
      
      // se 1 -> a, 0 -> b
      sel = 1'b0;
      
      //a = 1'b0;
      //b = 1'b0;
      D = 2'd0;
      
      #10;
      $finish;
    end

endmodule
