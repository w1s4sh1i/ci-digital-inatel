/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102-2
Type: Testbench
Data: november, 5 2025
*/

`timescale 1ns/1ps

module display_7seg_tb();

	localparam DELAY = 10, SAMPLES = 10; 
    reg [3:0] in;
    wire [6:0] out;

    integer i;

    display_7seg UUT (
        .in(in), .out(out)
    );

    initial begin
    
        	$dumpfile("CIDI-SD122-A102-2-3-dsp7.vcd");
		$dumpvars(0, display_7seg_tb);

		$display("|Input	|Display	|");
		$monitor("|%b	|%b	|", in, out);
		
		
        for(i = 0; i < SAMPLES; i = i + 1) begin
            in = i;
            #DELAY;
        end

        $finish;
    end

endmodule
