/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-106
Type: Laboratory
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps 

module demux_1xn #(parameter N = 4)(
    input D,
    input [$clog2(N)-1:0] S, // bit de ativacao
    output reg [N-1:0] Y
);
    integer i;
    always @(*) begin
        for(i = 0; i < N; i = i + 1) begin
            Y[i] <= D & (i == S);
        end
    end
endmodule
