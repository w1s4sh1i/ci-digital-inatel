/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Testbench
Data: november, 19 2025
*/

`timescale 1 ns / 1 ps;

module subtrator_4b_com2_tb;

    // Parâmetros
    localparam DELAY = 10, N = 4;

    // Entradas
    reg [N-1:0] A;
    reg [N-1:0] B;

    // Saídas
    wire [N-1:0] D;
    wire Cout;

    // Instância do módulo a ser testado
    subtrator_4b UUT (
        .A(A), .B(B), .cin(1'b1), // cin = 1, complemento de 2
        .sum(D), .cout(Cout)
    );

	
	initial begin
		
		$dumpfile("CIDI-SD122-A111-3.vcd"); 
        	$dumpvars(0, subtrator_4b_com2_tb); 
		
		$display("|A	|B	|Cin	|Cout	|Sum	|");
		$monitor("|%b	|%b	|1	|%b	|%b	|", A, B, Cout, D);
	
	end
	
    // Procedimento de teste
    initial begin
 
        // Test 1
        A = 4'b1010; // 10
        B = 4'b0011; // 3
        #DELAY;

        // Test 2
        A = 4'b0111; // 7
        B = 4'b0101; // 5
        #DELAY;

        // Test 3
        A = 4'b0101; // 5
        B = 4'b0110; // 6
        #DELAY;

        // Test 4
        A = 4'b1111; // 15
        B = 4'b0001; // 1
        #DELAY;

        $finish;
    end

endmodule
