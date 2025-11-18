/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-105
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux_4x1_param_tb;
    parameter N = 4;
    reg  [3:0] in0,in1,in2,in3;
    reg  [1:0]  sel;
    wire [3:0]  out;
    
    mux_4x1_param #(.N(N)) mux (
    .in0(in0),.in1(in1),.in2(in2),.in3(in3),
    .sel(sel),.out(out));

    initial begin
     	
     	$dumpfile("CID-SD122-A105-3.vcd");
        $dumpvars(0, mux_4x1_param_tb);

		$display("|Input 1	|Input 2	|Input 3	|Input 4	|Out	|");
		$monitor("|%b	|%b	|%b	|%b	|%b	|", in0, in1, in2, in3, sel, out);

        in0 = 4'b0101;
        in1 = 4'b0011;
        in2 = 4'b0100;
        in3 = 4'b1000;

        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

    end

endmodule
