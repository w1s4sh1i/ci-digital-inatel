
module decoder_NxM #(
    parameter N = 4,                 // número de bits de entrada
    parameter M = (1 << N)           // número de bits de saída = 2^N
)(
    input  wire [N-1:0] in,          // entrada binária
    output reg  [M-1:0] out          // saídas decodificadas
);

    // Lógica combinacional
    always @(*) begin
        out = 0;                     // zera todas as saídas
        out[in] = 1'b1;              // ativa a linha correspondente
    end

endmodule