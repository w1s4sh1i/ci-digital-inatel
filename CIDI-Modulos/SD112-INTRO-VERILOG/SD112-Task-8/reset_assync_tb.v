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

module testbench_ff_tb;

	localparam DELAY = 10;
	reg nrst_in;
    	reg clk;
    	reg vdd;

	wire Q_out;
	reg D_in; // [:0] D, paramtrizar para n bits

    top_module main_tb (
        .vdd(vdd), .clk(clk), .nrst_in(nrst_in), 
	.D(D_in), .Q(Q_out)
    );

    // Generate clock signal
    initial begin
        clk = 1'b0;
	// Modificar para controle com base no número de amostras (samples)
        forever #1 clk = ~clk; // Clock period T = 20 ns 
    end

    // Generate stimulus
    initial begin
        
    	// Specify the VCD file name
		$dumpfile("CIDI-SD112-A008-assync.vcd"); 
        $dumpvars(0, testbench_ff_tb); 	
		
		$display("|Clock A	|Reset	|Vdd	|D	|Q	|");
		$monitor("|%b 		|%b	|%b	|%b	|%b	|", clk, nrst_in, vdd, D_in, Q_out);
		
        {vdd, nrst_in, D_in} = 3'b100;
        #DELAY;
        
        {vdd, nrst_in} = 2'b11;
        #DELAY;

        {vdd, D_in} = 2'b01;
        #DELAY;
        
	{vdd, D_in} = 2'b10;
        #DELAY;
        
	{vdd, D_in} = 2'b11;
        #DELAY;
	
	{vdd, nrst_in, D_in} = 3'b101;
        #DELAY;
	
	#DELAY;
        $finish;
    end

endmodule
