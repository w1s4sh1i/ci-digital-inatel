/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux_8x1_tb;
	
	localparam DELAY = 10, WIDTH = 8; 
    reg  [WIDTH-1 : 0] in; 
    reg  [2:0] sel;  
    wire       out;

    mux_8x1 U1 (
        .in(in),
        .sel(sel),
        .out(out)
    );

    task mux;
        integer i;
        
     begin

		// $ 
		
        for (i = 0; i < WIDTH; i = i + 1) begin
            in  	= {8{1'b0}};  
            sel 	= i;
            in[sel] = 1'b1;        
            #DELAY;  
            
        end

 
     end

    endtask


   	initial begin
   	
   		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A014-2-mx81.vcd"); 
        	$dumpvars(0, mux_8x1_tb); 
		
		$display("|Input	 |Select|Ouput  |");
		$monitor("|%b|%b	|%b	|", in, sel, out);

		sel = 3'b0;
		in = 8'b0;
		#DELAY; 

		mux; // task call

		#DELAY; 
	       $finish; 
	end

endmodule
