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

module ieee754_adder_tb;

	localparam DELAY = 10; 
    reg [31:0] a, b;
    wire [31:0] result;

    ieee754_adder uut (
        .a(a),
        .b(b),
        .result(result)
    );
    
    initial begin
		
		$dumpfile("CIDI-SD122-A114-E.vcd"); 
    	$dumpvars(0, ieee754_adder_tb); 
		
		$display("|A				|B				|Result				|");
		$monitor("|%b|%b|%b|",
			a, b, result  
		);
	end

    initial begin
        // Teste de soma: 4,75 + 2,125 = 6,875 => 0_10000001_10111000000000000000000
        a = 32'b0_10000001_00110000000000000000000; // 4,75
        b = 32'b0_10000000_00010000000000000000000; // 2,125
        //add_sub = 0; // Soma
        #10;
   
        // Teste de soma: 9,5 + 3,75 = 13,25 => 0_10000010_10101000000000000000000
        a = 32'b0_10000010_00110000000000000000000; // 9,5
        b = 32'b0_10000000_11100000000000000000000; // 3,75
        #10;
    
        $finish;
    end
endmodule

