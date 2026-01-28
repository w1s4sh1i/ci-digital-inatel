/*
Program: CI Digital T2/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-109
Type: Laboratory
6Data: november, 16 2025
*/

`timescale 1 ns / 1 ps;

module behave_param_carry_look_ahead_adder #(parameter N = 8)(
    input	[N-1:0]	A, B,
    input         	Cin,
    output reg	[N-1:0]	Sum,
    output reg		Cout
);

    reg [N-1:0] P, G;
    reg [N  :0] C;

    integer i;

    always @(*) begin

	P = A ^ B;
        G = A & B;
        C[0] = Cin;

        // Carries (look-ahead)
	// [ ] Parametrizar com generate 
        for (i = 0; i < N; i = i + 1) begin
		C[i+1] = G[i] | (P[i] & C[i]);
        end

        // Soma final
        Sum = P ^ C[N-1:0];
        Cout = C[N];
    end

endmodule
