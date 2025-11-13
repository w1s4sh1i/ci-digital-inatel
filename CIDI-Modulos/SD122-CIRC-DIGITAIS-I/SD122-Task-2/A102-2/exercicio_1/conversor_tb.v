`timescale 1ns/1ps

module conversor_tb();

    reg [3:0] bcd_8421;
    wire [3:0] excesso_3;

    conversor CONV_TB(
        .bcd_8421(bcd_8421),
        .excesso_3(excesso_3)
    );

    initial begin
        bcd_8421 = 4'b0000; #10;
        bcd_8421 = 4'b0001; #10;
        bcd_8421 = 4'b0010; #10;
        bcd_8421 = 4'b0011; #10;
        bcd_8421 = 4'b0100; #10;
        bcd_8421 = 4'b0101; #10;
        bcd_8421 = 4'b0110; #10;
        bcd_8421 = 4'b0111; #10;
        bcd_8421 = 4'b1000; #10;
        bcd_8421 = 4'b1001; #10;
        $finish;
    end
    

endmodule