`timescale 1ns / 1ps

module demux_1x8_tb();

    localparam N = 8;
    reg D;
    reg [1:0] S;
    wire [N-1:0]Y;

    demux_1xn #(.N(N)) dmux(
        .D(D), .S(S), .Y(Y)
    );

    initial begin
        
        D = 0; S[1] = 0; S[0] = 0; #10;
        D = 0; S[1] = 0; S[0] = 1; #10;
        D = 0; S[1] = 1; S[0] = 0; #10;
        D = 0; S[1] = 1; S[0] = 1; #10;

        D = 1; S[1] = 0; S[0] = 0; #10;
        D = 1; S[1] = 0; S[0] = 1; #10;
        D = 1; S[1] = 1; S[0] = 0; #10;
        D = 1; S[1] = 1; S[0] = 1; #10;
    end

endmodule