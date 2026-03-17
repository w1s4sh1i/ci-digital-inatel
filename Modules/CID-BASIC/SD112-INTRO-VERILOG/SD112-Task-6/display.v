/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-006
Type: Laboratory
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module display( // #(parameter WIDTH_CMM = 4, WIDTH_LED = 8)(

    input       [3:0]   display_in,
    input 		dp,
    output  reg [6:0]   display_out 
);

	always @* begin

		// if dp == 1 -> display_out = {7{0}};
		case ({dp, display_in})	
			// reference -> {size(WIDTH_CMM) + size(dp)}h<decimal value>,  {WIDTH_LED-1}b<decimal value>
			// for() begin ... end -> 5'h{1,2,3,4,5,6,7,8,9,A,B,C,D,E,F};
			5'b00000: display_out = 7'b1111110; // index
			5'b00001: display_out = 7'b0110000;
			5'b00010: display_out = 7'b1101101;
			5'b00011: display_out = 7'b1111001;
			5'b00100: display_out = 7'b0110011;
			5'b00101: display_out = 7'b1011011;
			5'b00110: display_out = 7'b1011111;
			5'b00111: display_out = 7'b1110000;
			5'b01000: display_out = 7'b1111111;
			5'b01001: display_out = 7'b1111011;
			5'b01010: display_out = 7'b1110111;
			5'b01011: display_out = 7'b0011111;
			5'b01100: display_out = 7'b1001110;
			5'b01101: display_out = 7'b0111101;
			5'b01110: display_out = 7'b1001111;
			5'b01111: display_out = 7'b1000111;
			default: display_out = 7'b0000000;
			// Modificar dp para 1'b1 para informar que não
			// é possível demonstrar o valor no display.
		endcase


	end

endmodule
    
    
