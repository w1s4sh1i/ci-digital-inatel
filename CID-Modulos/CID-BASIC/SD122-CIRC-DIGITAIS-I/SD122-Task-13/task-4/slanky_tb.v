/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Testbench
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

// [ ] Testar método e analisar arquitetura 
module slanky_tb;

  // Parameters

  //Ports
  reg [15:0] A;
  reg [15:0] B;
  reg Cin;
  wire [15:0] Sum;
  wire Cout;

  slanky  slanky_inst (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
  );

	initial begin
		
		$dumpfile("CIDI-SD122-A113-4-3.vcd"); 
        $dumpvars(0, slanky_tb); 
		
		// Editar 
		$display("|A	 |B	  |C	   |Cout|Sum		|");
		$monitor("|%b|%b|%b|%b   |%b	|",
			A, B, C, Cout, Sum
		);
	end
	
    integer i, j;
    initial begin
        A = 16'd1; B = 16'd0; Cin = 1'b0;

        // loop de teste 
        for ( i = 0; i < 10; i=i+1) begin
            B = i;
            for (j = 0; j < 10; j=j+1) begin
                A = j;
                #10;
                if (Sum == (A+B)) 
                    #0;
                else begin
                    $display("Erro: soma = %b + %b = %b, resultado = %b", A, B, (A+B), Sum);
                    $finish;
                end
            end
        end
        $stop;
    end

endmodule
