module fifo_8x8_buffer_circular_v (
    input clk,
    input reset,
    input rd,
    input wr,
    input [7:0] w_data,
    output full,
    output empty,
    output reg [7:0] r_data
);

    reg [2:0] w_ptr;
    reg [2:0] r_ptr;
    reg [7:0] fifo_8x8_buffer [7:0];

    wire full_internal; 
    wire empty_internal;  

    assign full_internal = ((w_ptr + 1) % 8) == r_ptr; // Checa se o pointer está na mesma posição a menos que o pointer da escrtia
    assign empty_internal = w_ptr == r_ptr; // Checa se estão na mesma posição

    assign full = full_internal;
    assign empty = empty_internal;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_ptr <= 0;
        end else if (wr && !full_internal) begin
            fifo_8x8_buffer[w_ptr] <= w_data; // Insere o dato no buffer 
            w_ptr <= (w_ptr + 1) % 8; // Atualiza o valor do pointer de escrita de forma circular
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_ptr <= 0;
            r_data <= 8'b0;
        end else if (rd && !empty_internal) begin
            r_data <= fifo_8x8_buffer[r_ptr]; //Realiza a leitura do buffer
            r_ptr <= (r_ptr + 1) % 8; //Atualiza o valor do pointer de leitura de forma circular
        end
    end

endmodule
