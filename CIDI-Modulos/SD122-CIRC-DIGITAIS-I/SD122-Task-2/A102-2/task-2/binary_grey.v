module conversor(bcd_8421 , excesso_3); // bcd_5311 para bcd_8421
input [3:0] bcd_8421;
output reg [3:0] excesso_3;

always@(*) begin
    case(bcd_8421) // entra bcd_8421
    4'b0000: excesso_3 = 4'b0011; // 3
    4'b0001: excesso_3 = 4'b0100; // 4
    4'b0010: excesso_3 = 4'b0101; // 5
    4'b0011: excesso_3 = 4'b0110; // 6
    4'b0100: excesso_3 = 4'b0111; // 7
    4'b0101: excesso_3 = 4'b1000; // 8
    4'b0110: excesso_3 = 4'b1001; // 9
    4'b0111: excesso_3 = 4'b1010; // 10
    4'b1000: excesso_3 = 4'b1011; // 11
    4'b1001: excesso_3 = 4'b1100; // 12
    default: excesso_3 = 4'bxxxx;
    endcase
end
endmodule

module conversor_binario_grey(
    input [3:0] binario,
    output reg [3:0] gray
); // bcd_5311 para bcd_8421

always@(*) begin
    case(binario) // entra bcd_8421
    4'b0000: gray = 4'b0000;
    4'b0001: gray = 4'b0001;
    4'b0010: gray = 4'b0011;
    4'b0011: gray = 4'b0010;
    4'b0100: gray = 4'b0110;
    4'b0101: gray = 4'b0111;
    4'b0110: gray = 4'b0101;
    4'b0111: gray = 4'b0100;
    4'b1000: gray = 4'b1100;
    4'b1001: gray = 4'b1101;
    4'b1010: gray = 4'b1111;
    4'b1011: gray = 4'b1110;
    4'b1100: gray = 4'b1010;
    4'b1101: gray = 4'b1011;
    4'b1110: gray = 4'b1001;
    4'b1111: gray = 4'b1000;
    default: gray = 4'bxxxx;
    endcase
end
endmodule













