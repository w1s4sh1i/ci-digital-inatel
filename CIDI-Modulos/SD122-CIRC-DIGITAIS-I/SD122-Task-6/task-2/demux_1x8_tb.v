/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-106
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module demux_1x8_tb;
    reg din;
    reg [2:0] sel;
    wire [7:0] y;

    demux_1x8 uut(.d(din), .sel(sel), .y(y));

    initial begin
    
        $dumpfile("CID-SD122-A106-2.vcd");
        $dumpvars(0, demux_1x8_tb);

		$display("|Din	|Sel	|Y	|");
		$monitor("|%b	|%b	|%b	|", din, sel, y);

        din = 1'b1;
        
        sel = 3'b000; #5; 
        sel = 3'b001; #5; 
        sel = 3'b010; #5; 
        sel = 3'b011; #5; 
        sel = 3'b100; #5; 
        sel = 3'b101; #5; 
        sel = 3'b110; #5; 
        sel = 3'b111; #5; 

        $finish;
    end
endmodule
