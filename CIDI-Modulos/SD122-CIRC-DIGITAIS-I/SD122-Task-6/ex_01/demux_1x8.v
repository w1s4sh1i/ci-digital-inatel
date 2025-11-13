module demux_1x8 (
    input wire sel,
    input wire [2:0] addr,
    input wire in,
    output reg [7:0] out
);
    always @(*) begin
        out = 8'b0; // Default all outputs to 0
        if (sel) begin
            case (addr)
                3'b000: out[0] = in;
                3'b001: out[1] = in;
                3'b010: out[2] = in;
                3'b011: out[3] = in;
                3'b100: out[4] = in;
                3'b101: out[5] = in;
                3'b110: out[6] = in;
                3'b111: out[7] = in;
                default: out = 8'b0; // Safety default
            endcase
        end
    end
endmodule