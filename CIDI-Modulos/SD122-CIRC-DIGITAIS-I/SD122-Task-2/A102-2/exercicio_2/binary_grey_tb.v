`timescale 1ns/1ps

module conversor_binary_grey_tb();

    reg [3:0] binario;
    wire [3:0] gray;

    conversor_binario_grey GREY_TB(
        .binario(binario),
        .gray(gray)
    );

    initial begin
        binario = 4'b0000; #10;
        binario = 4'b0001; #10;
        binario = 4'b0010; #10;
        binario = 4'b0011; #10;
        binario = 4'b0100; #10;
        binario = 4'b0101; #10;
        binario = 4'b0110; #10;
        binario = 4'b0111; #10;
        binario = 4'b1000; #10;
        binario = 4'b1001; #10;
        binario = 4'b1010; #10;
        binario = 4'b1011; #10;
        binario = 4'b1100; #10;
        binario = 4'b1101; #10;
        binario = 4'b1110; #10;
        binario = 4'b1111; #10;
        $finish;
    end
    

endmodule