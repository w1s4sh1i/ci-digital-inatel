/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-107-1
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module decodificador_2x4_tb;

	localparam DELAY = 10;
    reg A, B;
    wire Y0, Y1, Y2, Y3;

    // Instancia o decodificador
    decodificador_2x4 DUT (
        .A(A), .B(B),
        .Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3)
    );

    initial begin
        
        $dumpfile("CID-SD122-A107-1-1.vcd");
        $dumpvars(0, decodificador_2x4_tb);

		$display("|A	|B	|Y3	|Y2	|Y1	|Y0	|");
		$monitor("|%b	|%b	|%b	|%b	|%b	|%b	|", A, B, Y3, Y2, Y1, Y0);
		
        // Sequência conforme a figura (00, 01, 10, 11)
        {A, B} = 2'b00; 
        #DELAY
        
        {A, B} = 2'b01; 
        #DELAY
        
        {A, B} = 2'b10;
        #DELAY
        
        {A, B} = 2'b11;
        #DELAY
        
        $finish;
    end
endmodule
