// RTL          -> com portas lógicas
// estrutural   -> com instancias 
// comportamental   -> é o que usa always

// 1ª Parte do Exercício 2
module mux2(a, b, sel, y);
    input a, b, sel;
    output y;

assign y = sel ? a : b; 

endmodule

// 2ª Parte do Exercício 2
module mux3(
   input [1:0] D, sel,
   output y
);

assign y = sel ? D[0] : D[1]; 

endmodule

module mux_est(a, b, sel, y); //estrutural
    input a, b, sel;
    output y;

    wire w1, w2;

    or I1(y,w1,w2);
    and I2(w1,!sel,a);
    and I3(w2, sel,b);

endmodule

module mux_rtl(a, b, sel, y);
    input a, b, sel;
    output y;

    wire n_sel, and1, and2;

    assign n_sel = ~sel;
    assign and1 = a & n_sel;
    assign and2 = sel & b;
    assign y = and1 | and2;

endmodule

/*
    Atividade 3
*/
module mux4_comport(a, b, sel, y); //comportamental 
    input a, b, sel;
    output reg y;

    always@(*) begin
        if(sel == 1'b0)
            y = a;
        else
            y = b;
    end

endmodule