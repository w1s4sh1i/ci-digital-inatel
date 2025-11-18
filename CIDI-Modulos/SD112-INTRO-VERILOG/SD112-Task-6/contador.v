/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-006
Type: Laboratory
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module contador ( // counter
    input        	clk, rst,
    output reg 	[3:0] 	cont = 4'b0000, 
    output reg 		dp = 1'b0,
    output 	[6:0]   out
);

    display leds ( .display_in(cont), .dp(dp), .display_out(out));

    always @(posedge clk or posedge rst) begin
        
        if (rst) begin
            cont <= 4'b0000;
            dp   <= 1'b0;
        end else if ({dp,cont}>= 5'hF) begin // dp = (& cont); cont = {4{~dp}} & cont; 
            cont <= 4'b0000;
            dp   <= 1'b1;  // {dp,cont} >= 5'hF
        end else begin
            cont <= cont + 1;
            dp   <= 1'b0;
        end
    end

endmodule
