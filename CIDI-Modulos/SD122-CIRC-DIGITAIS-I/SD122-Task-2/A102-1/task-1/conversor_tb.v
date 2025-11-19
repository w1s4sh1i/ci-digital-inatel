/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102
Type: Testbench
Data: november, 5 2025
*/

`timescale 1 ns / 1 ps;

module conversor_tb();

	localparam DELAY = 10; 
    wire A, B, C, D;
    reg E, F, G, H;

    top CONV_TB(
        .H(H), .G(G), .F(F), .E(E), 
        .D(D), .C(C), .B(B), .A(A)
    );

    initial begin
    
    	$dumpfile("CID-SD122-A102-1-1.vcd");
		$dumpvars(0, conversor_tb);

		$display("|A B C D	|E F G H	|");
		
		$monitor("|%b %b %b %b	|%b %b %b %b	|", A, B, C, D, E, F, G, H);
    
        {H,G,F,E} = 4'b0000; #DELAY;
        {H,G,F,E} = 4'b0001; #DELAY;
        {H,G,F,E} = 4'b0011; #DELAY;
        {H,G,F,E} = 4'b0100; #DELAY;
        {H,G,F,E} = 4'b0101; #DELAY;
        {H,G,F,E} = 4'b0111; #DELAY;
        {H,G,F,E} = 4'b1001; #DELAY;
        {H,G,F,E} = 4'b1011; #DELAY;
        {H,G,F,E} = 4'b1100; #DELAY;
        {H,G,F,E} = 4'b1101; #DELAY;

        $finish;
    end
    

endmodule
