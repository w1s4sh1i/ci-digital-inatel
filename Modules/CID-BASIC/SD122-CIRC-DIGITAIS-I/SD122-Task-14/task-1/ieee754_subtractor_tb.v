/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-114
Type:  Testbench
Data: november, 21 2025
*/

`timescale 1 ns / 1 ps;

module ieee754_subtractor_tb;

	localparam DELAY = 10; 
    reg [31:0] a, b;
    wire [31:0] result;

    ieee754_subtractor UUT (
        .a(a), .b(b),
        .result(result)
    );
    
    initial begin
		
		$dumpfile("CIDI-SD122-A114-1.vcd"); 
        $dumpvars(0, ieee754_subtractor_tb); 
		
		$display("|A	|B	|Result	|");
		$monitor("|%b	|%b	|%b	|",
			a, b, result  
		);
	end

    initial begin
        // Teste 1: 5.5 - 2.0 = 3.5 => 0_10000000_11000000000000000000000
        a = 32'b0_10000001_01100000000000000000000; // 5.5
        b = 32'b0_10000000_00000000000000000000000; // 2.0
        #DELAY
        
        // Teste 2: 10.75 - 6.25 = 4.5 => 0_10000001_00100000000000000000000
        a = 32'b0_10000010_01011000000000000000000; // 10.75
        b = 32'b0_10000001_10010000000000000000000; // 6.25
        #DELAY
        
        // Teste 3: 2.125 - 1.0 = 1.125 => 0_01111111_00100000000000000000000
        a = 32'b0_10000000_00010000000000000000000; // 2.125
        b = 32'b0_01111111_00000000000000000000000; // 1.0
        #DELAY
        
        // Teste 4: 1.0 - 1.0 = 0.0 => 0_00000000_00000000000000000000000
        a = 32'b0_01111111_00000000000000000000000; // 1.0
        b = 32'b0_01111111_00000000000000000000000; // 1.0
        #DELAY
        
        $finish;
    end
endmodule
