module decoder_8x3(
    input [7:0] in,
    output reg [2:0] out
);
    always @(*) begin
        casex(in)
            8'b00000001 : out = 3'b000;
            8'b00000010 : out = 3'b001;
            8'b00000100 : out = 3'b010;
            8'b00001000 : out = 3'b011;
            8'b00010000 : out = 3'b100;
            8'b00100000 : out = 3'b101;
            8'b01000000 : out = 3'b110;
            8'b10000000 : out = 3'b111;
            default     : out = 3'bxxx;
        endcase
    end

endmodule

module top(
    input [15:0] in,
    output [3:0] out
);
    
    wire [2:0] low_out;
    wire [2:0] high_out;
    wire high_active;

    decoder_8x3 dec_low(
        .in(in[7:0]),
        .out(low_out)
    );

    decoder_8x3 dec_high(
        .in(in[15:8]),
        .out(high_out)
    );

    assign high_active = |in[15:8];
    assign out = high_active ? {1'b1, high_out} : {1'b0, low_out};

endmodule