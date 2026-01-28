module fifo_NxN_buffer_circular
#( 
    parameter N = 16, W = 16
)
(
    input clk,
    input reset,
    input rd,
    input wr,
    input [N-1:0] w_data,
    output full,
    output empty,
    output reg [N-1:0] r_data
);

    reg [$clog2(N):0] w_ptr;
    reg [$clog2(N):0] r_ptr;
    reg [N-1:0] fifo_nxn_buffer [W-1:0];

    wire full_internal;
    wire empty_internal;

    assign full_internal = ((w_ptr + 1) % N) == r_ptr;
    assign empty_internal = w_ptr == r_ptr;

    assign full = full_internal;
    assign empty = empty_internal;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_ptr <= 0;
        end else if (wr && !full_internal) begin
            fifo_nxn_buffer[w_ptr] <= w_data;
            w_ptr <= (w_ptr + 1) % 8;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_ptr <= 0;
            r_data <= 8'b0;
        end else if (rd && !empty_internal) begin
            r_data <= fifo_nxn_buffer[r_ptr];
            r_ptr <= (r_ptr + 1) % 8;
        end
    end

endmodule
