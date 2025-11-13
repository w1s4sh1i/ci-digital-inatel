module S_D(
    input H,G,
    output D
);
    assign D = H & G;
endmodule

module S_C(
    input H,G,E,
    output C
);
    assign C = (!H & G & E) | (H & !G);
endmodule

module S_B(
    input H,G,F,E,
    output B
);
    assign B = (!H & G & !E) | (!G & F) | (H & !G);
endmodule

module S_A(
    input H,G,F,E,
    output A
);
    assign A = (!H & !G & !F & E) | (!H & G & !E) | (G & F) | (H & G & E) | (H & F);
endmodule

module top(
    input H,G,F,E,
    output D,C,B,A
);
    S_D sd(.H(H),.G(G),.D(D));
    S_C sc(.H(H),.G(G),.E(E),.C(C));
    S_B sb(.H(H),.G(G),.F(F),.E(E),.B(B));
    S_A sa(.H(H),.G(G),.F(F),.E(E),.A(A));
endmodule