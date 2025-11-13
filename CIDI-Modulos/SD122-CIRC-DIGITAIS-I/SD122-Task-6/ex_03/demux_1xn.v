module demux_1xn #(parameter N = 4)(
    input D,
    input [1:0] S, // bit de ativacao
    output reg [N-1:0] Y
);
    integer i;
    always @(*) begin
        for(i=0; i < N; i = i + 1) begin
            Y[i] <= D & (i == S);
        end
    end
endmodule