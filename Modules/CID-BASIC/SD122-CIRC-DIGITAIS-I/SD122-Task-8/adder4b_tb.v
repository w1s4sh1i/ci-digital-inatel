/*
Program: CI Digital 02/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-108
Type: Testbench
Data: november, 15 2025
*/

`timescale 1 ns / 1ps

module adder4b_tb;

	localparam DELAY = 10, WIDTH = 4;
    reg  [WIDTH-1 :0] A;
    reg  [WIDTH-1 :0] B;
    reg  cin;
    wire cout;
    wire [WIDTH-1 :0] sum;

    top_module DUT (
        .A(A), .B(B), .cin(cin),
        .cout(cout), .sum(sum)
    );
    
    initial begin
		
		$dumpfile("CIDI-SD122-A108.vcd"); 
        $dumpvars(0, adder4b_tb); 
		
		$display("|A	|B	|Cin	|Cout	|Sum	|");
		$monitor("|%b	|%b	|%b	|%b	|%b	|", A, B, cin, cout, sum );
	end
    
    initial begin
    
    	// testing report 
        cin = 1'b0;
        A = 4'b0011; // 3
        B = 4'b0111; // 7
        #DELAY;

        A = 4'b1101; // 13
        B = 4'b0011; // 3
        #DELAY;

        cin = 1'b1;
        A = 4'b1010; // 10
        B = 4'b0100; // 4
        #DELAY;
		
		cin = 1'b0;
        A = 4'b0000; // 0
        B = 4'b0000; // 0
        #DELAY;

        cin = 1'b1;
        A = 4'b0000; // 0
        B = 4'b1111; // 15
        #DELAY;

        $finish;
    end

endmodule
