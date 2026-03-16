/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-302)
Type: Laboratory
Data: febuary, 2 2026
*/

`timescale 1 ns / 1 ps
 
module fifo_8x8_buffer_circular #(
	parameter WIDTH = 8
)(
    input clk, reset, rd, wr,
    input [WIDTH-1 : 0] w_data,
    
    output full, empty,
    output reg [WIDTH-1 : 0] r_data
);

    reg [2:0] w_ptr, r_ptr;
    reg [WIDTH-1 : 0] fifo_8x8_buffer [WIDTH-1 : 0];

    wire full_internal, empty_internal;  

	// [X] Checar se o pointer está na mesma posição a menos que o pointer da escrita
    assign full_internal = ((w_ptr + 1) % WIDTH) == r_ptr; 
    assign full = full_internal;
    
    // [X] Checa se estão na mesma posição
    assign empty_internal = w_ptr == r_ptr; 
    assign empty = empty_internal;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_ptr <= 3'b000;
        end else if (wr && !full_internal) begin
        	// [x] Insere o dado no buffer 
            fifo_8x8_buffer[w_ptr] <= w_data; 
            // [x] Atualiza o valor do pointer de escrita de forma circular
            w_ptr <= (w_ptr + 1) % WIDTH; 
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_ptr <= 3'b000;
            r_data <= 8'b00000000;
        end else if (rd && !empty_internal) begin
        	//Realiza a leitura do buffer
            r_data <= fifo_8x8_buffer[r_ptr];
            //Atualiza o valor do pointer de leitura de forma circular 
            r_ptr <= (r_ptr + 1) % WIDTH; 
        end
    end

endmodule
