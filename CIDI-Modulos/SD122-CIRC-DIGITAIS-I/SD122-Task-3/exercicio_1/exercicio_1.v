module Codificador_Prioridade(
    input wire [15:0] in,
    output reg [3:0] out
);
   always @(*) begin
        casex (in)
            16'b1xxxxxxxxxxxxxx : out = 3'b1111;
            16'b01xxxxxxxxxxxxx : out = 3'b1110;
            16'b001xxxxxxxxxxxx : out = 3'b1101;
            16'b0001xxxxxxxxxxx : out = 3'b1100;
            16'b00001xxxxxxxxxx : out = 3'b1011;
            16'b000001xxxxxxxxx : out = 3'b1010;
            16'b0000001xxxxxxxx : out = 3'b1001;
            16'b00000001xxxxxxx : out = 3'b1000;
            16'b000000001xxxxxx : out = 3'b0111;
            16'b0000000001xxxxx : out = 3'b0110;
            16'b00000000001xxxx : out = 3'b0101;
            16'b000000000001xxx : out = 3'b0100;
            16'b0000000000001xx : out = 3'b0011;
            16'b00000000000001x : out = 3'b0010;
            16'b000000000000001 : out = 3'b0001;
            16'b000000000000000 : out = 3'b0000;
            default: out = 3'b0000;
        endcase
   end

endmodule