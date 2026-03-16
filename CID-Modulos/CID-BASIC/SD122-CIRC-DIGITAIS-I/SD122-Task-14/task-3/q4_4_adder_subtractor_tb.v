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

module q4_4_adder_subtractor_tb;
    
    reg  [7:0] A, B;
    reg        SUB;
    wire [7:0] Result;
    wire       Overflow;

    q4_4_adder_subtractor UUT (
        .A(A), .B(B),
        .SUB(SUB),
        .Result(Result),
        .Overflow(Overflow)
    );

	initial begin
		
		$dumpfile("CIDI-SD122-A114-5.vcd"); 
        $dumpvars(0, q5_3_multiplier_tb); 
		
		$display("|A	|B	|P	|");
		$monitor("|%b	|%b	|%b	|",
			q5_3_to_real(A), q5_3_to_real(B), q5_3_to_real(P)
		);
	end
    // Função para converter Q4.4 em decimal com sinal
    function real q4_4_to_real(input [7:0] val);
        begin
            if (val[7] == 1)
                q4_4_to_real = -((~val + 1) & 8'hFF) / 16.0;
            else
                q4_4_to_real = val / 16.0;
        end
    endfunction

    initial begin
        
		A = 8'b00010000; B = 8'b00001000; SUB = 0; 
		#DELAY;
		// 1.0 + 0.5

		A = 8'b11100000; B = 8'b00010000; SUB = 0; 
		#DELAY;
		// -2.0 + 1.0

		A = 8'b00011000; B = 8'b00001000; SUB = 1; 
		#DELAY;
		// 1.5 - 0.5

		A = 8'b01111111; B = 8'b00000001; SUB = 0; 
		#DELAY;
		// 7.9375 + 0.0625 (overflow)

		A = 8'b10000000; B = 8'b00000001; SUB = 1; 
		#DELAY;
		// -8.0 - 0.0625 (overflow)
		
		$finish;
    end
endmodule
