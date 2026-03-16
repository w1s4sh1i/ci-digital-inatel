/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-007
Type: Testbench
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module debounce_64_tb;

    // Entradas
    localparam DELAY = 50; 
    reg button;
    reg clk;
    reg reset;

    // Saída
    wire result;

    // Instancia o módulo sob teste (UUT)
    debounce_64 uut64 (
        .clk(clk),
        .noisy_in(button),
        .clean_out(result)
	//.reset(reset)
    );

    // Geração do clock: período = 20 ns (50 MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Geração de estímulos
    initial begin
    	// Specify the VCD file name
	$dumpfile("CID-SD112-A007-2.vcd"); 
        $dumpvars(0, debounce_64_tb); 
	
		// Editar
	$display("|Clock	|Button	|Reset	|Result	|");
	$monitor("|%b	|%b	|%b	|%b	|", button, clk, reset, result);
        
        // Inicializa sinais
        button = 0;
        reset = 1;
        
        #DELAY;
        reset = 0;

        // Simula ruído de bouncing e pressionamento real
        #500 	button = 0;
        #DELAY  button = 1;  // Glitch / bounce
        #200 	button = 0;
        #DELAY  button = 1;  // Glitch / bounce
        #150 	button = 0;
        #100 	button = 1;  // Botão pressionado (estável)
        #5000 	button = 0; // Mantém pressionado por tempo

        // Simula ruído ao soltar
        #DELAY  button = 1;  // Glitch / bounce
        #200 	button = 0;
        #DELAY  button = 1;  // Glitch / bounce
        #200 	button = 0;  // Botão liberado (estável)

        #2000;            // Tempo extra pra observação
        $finish;
    end

endmodule
