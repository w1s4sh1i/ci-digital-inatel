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
Type: TestBench
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module data_path_tb;

    reg sel12, sel21, escrita, clk, reset, carry_in; // Reestruturar
    reg [2:0] operacao;   
    reg [1:0] reg_addr;
    reg [3:0] dados;

    wire [3:0] resultado; 
    wire carry_out;

    data_path DUT (
        .sel12(sel12), .sel21(sel21),
        .escrita(escrita),
        .clk(clk),
        .reset(reset),
        .carry_in(carry_in),
        .operacao(operacao),
        .reg_addr(reg_addr),
        .dados(dados),
        .resultado(resultado),
        .carry_out(carry_out)
    );

	initial begin
		
		$dumpfile("CIDI-SD122-A113-1.vcd"); 
        	$dumpvars(0, data_path_tb); 
		
		$display("|Write	|Reset	|Cin |OP  |Sel12|Sel21  |Reg	|Data	|Result	|Cout	|");
		$monitor("|%b	|%b	|%b   |%b |%b	|%b	|%b	|%b	|%b	|%b	|",
			escrita, reset, carry_in, operacao, sel12, sel21, reg_addr, dados, resultado, carry_out
		);
	end
	
    always #5 clk = ~clk;

    initial begin
	// Organizar sinais;
	clk 	 = 0;
        sel12    = 0;
        sel21    = 0;
        escrita  = 0;
        reset    = 1;
        carry_in = 0;
        operacao = 3'b000;
        reg_addr = 2'b00;
        dados    = 4'b0000;
        #50;
        reset 	 = 0;    
        #20;

		// Soma 
        operacao = 3'b100;

      
        sel21   = 0;       
        dados   = 4'b1100;
        reg_addr= 2'b00;
        escrita = 1;
        #20;
        escrita = 0;

    
        dados   = 4'b0010;
        reg_addr= 2'b01;
        escrita = 1;
        #20;
        escrita = 0;
        
        #1; 
        reg_addr= 2'b00;
        sel12 = 1'b0;  
        #10;
     
        #1;
        reg_addr= 2'b01; 
        sel12 = 1'b1;
   
        #40;

	// Subtração       

        operacao = 3'b101;
        sel21 = 1'b0;       
        dados   = 4'b1100;
        reg_addr= 2'b00;
        escrita = 1;
        #20;
        
        escrita = 0;
        dados   = 4'b0010;
        reg_addr= 2'b01;
        escrita = 1;
        #20;
        escrita = 0;

        #1; 
        reg_addr= 2'b00;
        sel12 = 1'b0;  
        #10;
     
        #1;
        reg_addr= 2'b01; 
        sel12 = 1'b1;
        #40;

        sel21 = 1'b1;
        #40;
        $finish;
    end

endmodule
