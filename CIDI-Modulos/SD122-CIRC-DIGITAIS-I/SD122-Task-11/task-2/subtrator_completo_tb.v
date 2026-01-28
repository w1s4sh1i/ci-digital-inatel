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
Data: november, 18 2025
*/

`timescale 1 ns / 1 ps;

module subtrator_tb;

	localparam DELAY = 10;	
    reg A, B, BorrowIn;
    wire D0, D1, D2, B0, B1, B2;

    top_module DUT (
        .A(A), .B(B), .BorrowIn(BorrowIn),
        .D_1(D0), .D_2(D1), .D_3(D2), 
        .BorrowOut_1(B0), .BorrowOut_2(B1), .BorrowOut_3(B2)
    );
	
	initial begin
		
		$dumpfile("CIDI-SD122-A111-2.vcd"); 
        $dumpvars(0, subtrator_tb); 
		
		$display("|A |B |Borrow In  |D 2 1 0|Borrow Out	|");
		$monitor("|%b |%b |%b	  | %b %b %b |%b %b %b	|"
			, A, B, BorrowIn, D2, D1, D0, B0, B1, B2
		);
	end
	
    initial begin
        BorrowIn = 0;
        {A,B} = 2'b00; #DELAY;
        {A,B} = 2'b01; #DELAY;
        {A,B} = 2'b10; #DELAY;
        {A,B} = 2'b11; #DELAY;
        
		BorrowIn = 1;
        {A,B} = 2'b00; #DELAY;
        {A,B} = 2'b01; #DELAY;
        {A,B} = 2'b10; #DELAY;
        {A,B} = 2'b11; #DELAY;
        $finish;
    end

endmodule
