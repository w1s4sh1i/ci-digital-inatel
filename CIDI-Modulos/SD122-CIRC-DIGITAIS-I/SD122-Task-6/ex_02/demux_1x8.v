module demux_1x2(
    input din,
    input sel,
    output y0, y1
);
    assign y0 = din & ~sel;
    assign y1 = din &  sel;

endmodule

module demux_1x8(
    input d,
    input [2:0] sel,
    output [7:0] y
);
    wire [1:0] m;
    wire [3:0] n;

    // Nível 1: primeiro demux
    demux_1x2 d0 (.din(d), .sel(sel[2]), .y0(m[0]), .y1(m[1]));
    
    // Nível 2: cada saída do nível 1 vai para outro demux
    demux_1x2 d1 (.din(m[0]), .sel(sel[1]), .y0(n[0]), .y1(n[1]));
    demux_1x2 d2 (.din(m[0]), .sel(sel[1]), .y0(n[2]), .y1(n[3]));  

    // Nível 3: cada saída do nível 2 vai para outro demux
    demux_1x2 d3 (.din(n[0]), .sel(sel[0]), .y0(y[0]), .y1(y[1]));
    demux_1x2 d4 (.din(n[1]), .sel(sel[0]), .y0(y[2]), .y1(y[3]));
    demux_1x2 d5 (.din(n[2]), .sel(sel[0]), .y0(y[4]), .y1(y[5]));
    demux_1x2 d6 (.din(n[3]), .sel(sel[0]), .y0(y[6]), .y1(y[7]));

endmodule