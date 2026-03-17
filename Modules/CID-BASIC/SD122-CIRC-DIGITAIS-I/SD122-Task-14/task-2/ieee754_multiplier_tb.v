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

module ieee754_multiplier_tb;

	localparam DELAY = 10; 
    reg [31:0] a, b;
    wire [31:0] result;

    ieee754_multiplier uut (
        .a(a), .b(b),
        .result(result)
    );

	initial begin
		
		$dumpfile("CIDI-SD122-A114-2.vcd"); 
        $dumpvars(0, ieee754_multiplier_tb); 
		
		$display("|A	|B	|Result	|");
		$monitor("|%b	|%b	|%b	|",
			a, b, result  
		);
	end
	
    initial begin
        
        // Teste 1: 2.0 * 3.0 = 6.0
        a = 32'b0_10000000_00000000000000000000000; // 2.0
        b = 32'b0_10000000_10000000000000000000000; // 3.0
        #DELAY
        
        // Teste 2: 1.5 * 4.0 = 6.0
        a = 32'b0_01111111_10000000000000000000000; // 1.5
        b = 32'b0_10000001_00000000000000000000000; // 4.0
        #DELAY
        
        // Teste 3: 5.5 * 2.0 = 11.0
        a = 32'b0_10000001_01100000000000000000000; // 5.5
        b = 32'b0_10000000_00000000000000000000000; // 2.0
        #DELAY
        
        // Teste 4: 1.0 * 1.0 = 1.0
        a = 32'b0_01111111_00000000000000000000000; // 1.0
        b = 32'b0_01111111_00000000000000000000000; // 1.0
        #DELAY

        $finish;
    end
endmodule
