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
Type: Laboratory
Data: november, 18 2025
*/

`timescale 1 ns / 1 ps;

module top_module (
    input A, B,
    output D_out1, D_out2, D_out3, D_out4,
    output B_out1, B_out2, B_out3, B_out4
);
    meio_subtrator_rtl1 MSR0 (
    	.A(A), .B(B), 
    	.D(D_out1), .Borrow(B_out1)
    );
    
    meio_subtrator_rtl2 MSR1 (
    	.A(A), .B(B), 
    	.D(D_out2), .Borrow(B_out2)
    );
    
    meio_subtrator_comp1 MSC0(
    	.A(A), .B(B), 
    	.D(D_out3), .Borrow(B_out3)
    );
    
    meio_subtrator_comp2 MSC1(
    	.A(A), .B(B), 
    	.D(D_out4), .Borrow(B_out4)
    );

endmodule
