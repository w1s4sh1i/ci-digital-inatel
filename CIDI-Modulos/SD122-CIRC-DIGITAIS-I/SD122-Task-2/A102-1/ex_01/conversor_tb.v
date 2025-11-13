`timescale 1ns/1ps
module conversor_tb();

    wire A, B, C, D;
    reg E, F, G, H;

    top CONV_TB(
        .H(H), .G(G), .F(F), .E(E), 
        .D(D), .C(C), .B(B), .A(A)
    );

    initial begin
    
        {H,G,F,E} = 4'b0000; #10;
        {H,G,F,E} = 4'b0001; #10;
        {H,G,F,E} = 4'b0011; #10;
        {H,G,F,E} = 4'b0100; #10;
        {H,G,F,E} = 4'b0101; #10;
        {H,G,F,E} = 4'b0111; #10;
        {H,G,F,E} = 4'b1001; #10;
        {H,G,F,E} = 4'b1011; #10;
        {H,G,F,E} = 4'b1100; #10;
        {H,G,F,E} = 4'b1101; #10;

        $finish;
    end
    

endmodule