/*
Program: CI Digital T2/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-106
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module demux1xn_tb(); // Exemplo de 

    localparam N = 8, M = $clog2(N), DELAY = 10;
    reg D;
    reg  [M-1:0] S;
    wire [N-1:0] Y;

    demux1xn #(.N(N)) dmux(
        .D(D), .S(S), 
        .Y(Y)
    );

    initial begin
    
    	$dumpfile("CIDI-SD122-A106-3.vcd");
        $dumpvars(0, demux1xn_tb);

		$display("|D	|S	|Y		|");
		$monitor("|%b	|%b	|%b	|", D, S, Y);
        
		D = 1'b0; // Desativo
		 
		S = 2'b00; 
		#DELAY;
		
		S = 2'b01; 
		#DELAY;
		
		S = 2'b10;
		#DELAY;
		
		S = 2'b11; 
		#DELAY;

		D = 1'b1; // Ativo 
		
		S = 2'b00; 
		#DELAY;
		 
		S = 2'b01; 
		#DELAY;
		
		S = 2'b10; 
		#DELAY;
		 
		S = 2'b11; 
		#DELAY;
		
    end

endmodule
