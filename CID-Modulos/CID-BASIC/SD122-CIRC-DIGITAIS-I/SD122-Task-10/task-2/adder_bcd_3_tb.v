/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-110
Type: Testbench
Data: november, 17 2025
*/

`timescale 1 ns / 1 ps

module adder_bcd_3_tb;
	
	localparam DELAY = 10; 
    reg  [11:0] A, B;
    reg         Cin;
    wire [11:0] S;
    wire        Cout;

    // Instancia o DUT (Device Under Test)
    adder_bcd_3 DUT (
        .A(A), .B(B), .Cin(Cin),
        .S(S), .Cout(Cout)
    );

    initial begin
		
		$dumpfile("CIDI-SD122-A110-2.vcd"); 
        $dumpvars(0, adder_bcd_3_tb); 
		
		$display("|A		|B		|Cin|Cout|Sum		|");
		$monitor("|%b	|%b	|%b  |%b   |%b	|", A, B, Cin, Cout, S);
	end

	initial begin
        
		Cin = 0;
		
		// Case 1: 123 + 456 = 579
        A = 12'h123;  
		B = 12'h456;
        #DELAY;

        // Case 2: 99 + 001 = 100 (carry entre dígitos)
        A = 12'h099;
		B = 12'h001;
        #DELAY;

        // Case 3: 275 + 725 = 1000 (carry final)
        A = 12'h275;
		B = 12'h725;
        #DELAY;
		
		Cin = 1;
        // Case 4: 999 + 001 = 1000
        A = 12'h999;
		B = 12'h001;
        #DELAY;

        // Case 5: 500 + 500 = 1000
        A = 12'h500;
		B = 12'h500;
        #DELAY;

        $finish;
    end

endmodule
