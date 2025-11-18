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
Type: Testbench
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module contador_tb;

    localparam DELAY = 10; 
    reg clk,rst;
    wire [3:0] cont;
    wire dp;
    wire [6:0] out;

    contador cont1 (.cont(cont), .dp(dp), .out(out), .clk(clk), .rst(rst));

    integer i;

    initial begin
  	
	
	// Specify the VCD file name
	$dumpfile("CID-SD112-A006-count.vcd"); 
	$dumpvars(0, contador_tb); 
	
	$display("|reset	|count	|dp	|out		|"); // Alterar
    	$monitor("|%b	|%b	|%b	|%b	|", rst, cont, dp, out);
        
	clk = 1'b0;
        rst =1'b0; 
        
	for (i = 0; i < DELAY*2; i = i + 1) begin
            #DELAY clk = ~clk;  
        end

        rst = 1'b1; 
        #DELAY;
        
	rst = 1'b0;
        for (i = 0; i < DELAY-2; i = i + 1) begin
            #DELAY clk = ~clk; 
        end
		
	#DELAY;
        $finish;
    end

endmodule
