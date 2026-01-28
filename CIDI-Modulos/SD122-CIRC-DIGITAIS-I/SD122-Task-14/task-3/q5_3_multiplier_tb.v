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

module q5_3_multiplier_tb;

	localparam DELAY = 10; 
    reg  signed [7:0] A, B;
    wire signed [7:0] P;

    q5_3_multiplier UUT (
        .A(A),
        .B(B),
        .P(P)
    );
	initial begin
		
		$dumpfile("CIDI-SD122-A114-6.vcd"); 
        $dumpvars(0, q5_3_multiplier_tb); 
		
		$display("|A	|B	|P	|");
		$monitor("|%b	|%b	|%b	|",
			q5_3_to_real(A), q5_3_to_real(B), q5_3_to_real(P)
		);
	end
	
    // Conversor Q5.3 para número real com sinal
    function real q5_3_to_real(input signed [7:0] val);
        begin
            q5_3_to_real = val / 8.0;
        end
    endfunction

    initial begin
        
		A = 8'b00010000; B = 8'b00001000; 
		#DELAY;

		// 2.0 x 1.0


		A = 8'b11100000; B = 8'b00001000; 
		#DELAY;

		// -4.0 x 1.0


		A = 8'b00011000; B = 8'b00011000; 
		#DELAY;

		// 3.0 x 3.0


		A = 8'b10000000; B = 8'b00000001; 
		#DELAY;

		// -16.0 x 0.125


		A = 8'b01111111; B = 8'b01111111; 
		#DELAY;

		// Máximo positivo x máximo positivo
       

        $finish;
    end
endmodule
