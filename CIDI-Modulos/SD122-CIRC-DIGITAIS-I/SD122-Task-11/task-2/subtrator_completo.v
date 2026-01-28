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

//Descrição RTL 1
module subtrator_completo_rtl1(
    input A, B, BorrowIn ,
    output D, BorrowOut
);
    // Diferença (D) e BorrowOut calculados usando expressões lógicas
    assign D = A ^ B ^ BorrowIn; // XOR para a diferença
    assign BorrowOut = (~A & B) | (~(A ^ B) & BorrowIn); // Lógica do BorrowOut

endmodule

//Descrição RTL 2
module subtrator_completo_rtl2(
    input A, B, BorrowIn ,
    output D, BorrowOut
);
    wire w1, w2, w3, w4, w5, w6;
    // Diferença: D = A ^ B ^ BorrowIn
    xor (w1, A, B);
    xor (D, w1, BorrowIn);
    // BorrowOut = (~A & B) | (~(A ^ B) & BorrowIn)
    not (w2, A); // ~A
    and (w3, w2, B); // ~A & B
    xor (w4, A, B); // A ^ B
    not (w5, w4); // ~(A ^ B)
    and (w6, w5, BorrowIn); // ~(A ^ B) & BorrowIn
    or (BorrowOut , w3, w6); // (~A & B) | (~(A ^ B) & BorrowIn)

endmodule

//Descrição comportamental (3)
module subtrator_completo_comportamental1(
    input A, B, BorrowIn ,
    output reg D, BorrowOut
);
    always @(*) begin
        D <= A ^ B ^ BorrowIn;
        // Usar ternário ou o lógica direta; 
        // BorrowOut <= (~A & B) | (~(A ^ B) & BorrowIn)
        if (~A & B) 
            BorrowOut <= 1'b1;
        else if (~(A ^ B) & BorrowIn)
            BorrowOut <= 1'b1;
        else
            BorrowOut <= 1'b0;
    end
endmodule

// Split files
module top_module (
    input A, B, BorrowIn,
    output D_1, D_2, D_3, BorrowOut_1, BorrowOut_2, BorrowOut_3
);
    subtrator_completo_rtl1 DUT0 ( 
    	.A(A), .B(B), .BorrowIn(BorrowIn), 
    	.D(D_1), .BorrowOut(BorrowOut_1)
    );
    
    subtrator_completo_rtl2 DUT1 ( 
    	.A(A), .B(B), .BorrowIn(BorrowIn), 
    	.D(D_2), .BorrowOut(BorrowOut_2)
    );
    
    subtrator_completo_comportamental1 DUT2( 
    	.A(A), .B(B), .BorrowIn(BorrowIn), 
    	.D(D_3), .BorrowOut(BorrowOut_3)
    );

endmodule
