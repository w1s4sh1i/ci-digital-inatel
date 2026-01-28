/*
Program: CI Digital T2/2025
Class: Circuito Digitais II 
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-20X
Type: Laboratory
Data: november, 30 2025
*/

`timescale 1 ns / 1 ps;

/*
Program: CI Digital T2/2025
Class: Circuito Digitais II 
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Testbench
Data: november, 30 2025
*/

`timescale 1 ns / 1 ps;

module <>_tb;
	reg data_in;
	wire data_outl, data_outi;
	integer i = 1; 
	
	localparam DELAY = 1, TEST_NUMBER = 5; 
	
	<> n1 (
		.signal(data_in),
		.not_logic(data_outl), .not_instance(data_outi)
	); 
	
	initial begin
		
		$dumpfile("CIDI-SD132-A20x.vcd"); 
        $dumpvars(0, <>_tb); 
		
		$display("|A	|B	|Cin	|Cout	|Sum	|";
		$monitor("|%b	|%b	|%b	|%b	|%b |");
			, A, B, cin, cout, sum
		);
	end
	
	initial begin

		data_in = 1'b0; 
		
		// sv -> for(integer i = 0; i < TEST_NUMBER; ++i)
		for(; i < TEST_NUMBER; i = i + 1) begin
			#DELAY;                                                      
			data_in = ~data_in;
		end
	end

endmodule
