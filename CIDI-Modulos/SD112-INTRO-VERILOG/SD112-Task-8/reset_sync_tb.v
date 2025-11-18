/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-008
Type: Testbench
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module reset_sync_tb;

	localparam DELAY = 20;
	reg           clk;
	reg           n_rst;
	reg    [1:0]  D_in;
	wire   [1:0]  Q_out;

    reset_sync U1 (
        .clk(clk),
        .n_rst(n_rst),
        .D_in(D_in),
        .Q_out(Q_out)
    );

    // Alterar para melhor controle
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk; 
    end

    initial begin
    
    	// Specify the VCD file name
	$dumpfile("CIDI-SD112-A008-sync.vcd"); 
        $dumpvars(0, reset_sync_tb); 
		
		
	$display("|Clock A	|Reset	|D	|Q	|");
	$monitor("|%b 		|%b	|%b	|%b	|", clk, n_rst, D_in, Q_out );
		
        D_in = 2'b00;
        n_rst = 1'b0; 
        #DELAY;
        
        n_rst = 1'b1;
        #(DELAY*10); // testar
        
        D_in = 2'b10;
        #(DELAY*2); 
        
        D_in = 2'b01;
        #(DELAY*2); 
        
        D_in = 2'b11;
        #(DELAY*2); 
        
        n_rst = 1'b0; 
        #(DELAY*3); 
        
        n_rst = 1'b1;       
        #(DELAY*8);
 	
	#DELAY
        $finish; 
    end

endmodule
