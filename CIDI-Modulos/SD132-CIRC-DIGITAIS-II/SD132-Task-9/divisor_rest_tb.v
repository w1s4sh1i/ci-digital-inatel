/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-209
Type: Testbench
Data: november, 26 2025
*/

`timescale 1 ns / 1 ps

module divisor_rest_tb;

    localparam DELAY = 10, N = 4;
    
    reg clk, start,rst;
    reg  [N   : 0]  divisor;
    reg	 [N-1 : 0] dividendo;
    
    wire [N-1 : 0] quociente, resto; 
    wire [  2 : 0] status;

    divisor_rest #(.N(N)) DUT (
    	.clk(clk), .start(start), .rst(rst),
    	.divisor(divisor), .dividendo(dividendo),
    	.quociente(quociente), .current_state(status), .resto(resto)
    );
    
    initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD132-A209.vcd"); 
		$dumpvars(0, divisor_rest_tb); 

		// Editar
		$display("|STATE|START|RESET|DIVISOR|DIVIDENDO|QUOCIENTE|RESTO|");
		$monitor("|%b  |%b    |%b    |%b  |%b     |%b     |%b |", 
			  status, start, rst, divisor, dividendo, quociente, resto
		); 
	end


    always #(DELAY/10) clk = ~clk;

    initial begin
        
        {clk, start} = 2'b00;
        divisor = 5'd3; 
        dividendo = 4'd11;
        
        rst = 1; 
        #(DELAY/2);
        
        rst = 0; 
        start = 1'b1;
		#(DELAY/2);

		start = 1'b0; 
        #(DELAY*4);
	
        $finish;
    end
      
endmodule
