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
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module bcd_to_ec3_tb();

	localparam DELAY = 10; 
    reg a,b,c,d;
    wire s0, s1, s2, s3;

    integer i;

    bcd_to_ex3 upp(
        .a(a), .b(b), .c(c), .d(d),
        .s0(s0), .s1(s1), .s2(s2), .s3(s3)
    );

    initial begin
        
        $dumpfile("CID-SD122-A102-1-2.vcd");
		$dumpvars(0, bcd_to_ec3_tb);

		$display("||A B C D	|S3 S2 S1 S0	|");
		
		$monitor("|%b %b %b %b	|%b %b %b %b |", a, b, c, d, s3, s2, s1, s0);

        for (i = 0; i < 10; i = i + 1) begin
            {a, b, c, d} = i[3:0];
            #DELAY;
        end
        $finish;
    end

endmodule
