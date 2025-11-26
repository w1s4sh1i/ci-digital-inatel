/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-103
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module decoder16x4_tb;

	localparam DELAY = 10, WIDTH_IN = 16, WIDTH_OUT = 4; 
    	reg  [WIDTH_IN-1  : 0] in;
    	wire [WIDTH_OUT-1 : 0] out;

    // Instancia do módulo topo
    top_module UUT (
        .in(in),
        .out(out)
    );

    initial begin
		
	$dumpfile("CIDI-SD122-A103-3.vcd");
	$dumpvars(0, decoder16x4_tb);

	$display("|In			|Out	|");
	$monitor("|%b	|%b	|", in, out);

        // Testando todos os bits
        in = 16'b0000000000000001; #DELAY;
        in = 16'b0000000000000010; #DELAY;
        in = 16'b0000000000000100; #DELAY;
        in = 16'b0000000000001000; #DELAY;
        in = 16'b0000000000010000; #DELAY;
        in = 16'b0000000000100000; #DELAY;
        in = 16'b0000000001000000; #DELAY;
        in = 16'b0000000010000000; #DELAY;
        in = 16'b0000000100000000; #DELAY;
        in = 16'b0000001000000000; #DELAY;
        in = 16'b0000010000000000; #DELAY;
        in = 16'b0000100000000000; #DELAY;
        in = 16'b0001000000000000; #DELAY;
        in = 16'b0010000000000000; #DELAY;
        in = 16'b0100000000000000; #DELAY;
        in = 16'b1000000000000000; #DELAY;

        $finish;
    end

endmodule
