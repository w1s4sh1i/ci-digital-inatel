// A - Modulo Multiplicador usando CSA simplificado com apenas dois CSAs
`timescale 1 ns / 1 ps

module multiplier_csa #( parameter WIDTH = 4) (
	input [WIDTH -1:0] multiplicand ,
	input [WIDTH -1:0] multiplier ,
	output [2* WIDTH -1:0] product
);
	wire [2* WIDTH -1:0] partial_products [WIDTH -1:0]; // Produtos parciais estendidos
	wire [2* WIDTH -1:0] sum_stage1 , sum_stage2 ; // Somadores parciais
	wire [2* WIDTH -1:0] carry_stage1 , carry_stage2 ; // Carrys parciais

	// Geracao dos produtos parciais
	genvar i;
	generate
		for (i = 0; i < WIDTH ; i = i + 1) begin : gen_partial_products
			assign partial_products [i] = multiplier [i] ? ( multiplicand << i) : 0;
		end
	endgenerate

	// Primeira etapa : somar os primeiros dois produtos parciais
	parameterized_csa #(2* WIDTH ) csa_stage1 ( 
		.A( partial_products [0]),
		.B( partial_products [1]),
 		.Cin( partial_products [2]),
		.Sum( sum_stage1 ),
 		.Cout(carry_stage1)
	);

	// Segunda etapa : somar os resultados intermediarios
	parameterized_csa #(2* WIDTH ) csa_stage2 (
		.A( partial_products [3]),
		.B( sum_stage1 ),
		.Cin( carry_stage1 << 1),
	 	.Sum( sum_stage2 ),
		.Cout( carry_stage2 )
	);

	// Produto final
	assign product = sum_stage2 + ( carry_stage2 << 1) ; // Concatena soma e carry diretamente
endmodule

// Test bench
module multiplier_csa_tb;

	reg [3:0] multiplicand;
	reg [3:0] multiplier;
	wire [7:0] product;

	// Instancia do multiplicador
	multiplier_csa #(4) uut (
		.multiplicand ( multiplicand ) ,
 		.multiplier ( multiplier ) ,
 		.product ( product )
	);

	initial begin
		// Testar combinacoes de entradas
		// Adicionar um $monitor();
		multiplicand = 4’ b0011 ; // 3
		multiplier = 4’ b0101 ; // 5
		#10;
		$display (" Multiplicand : %d, Multiplier : %d, Product : %d", multiplicand , multiplier , product );
		
		multiplicand = 4’ b1111 ; // 15
		multiplier = 4’ b0001 ; // 1
		#10;
		$display (" Multiplicand : %d, Multiplier : %d, Product : %d", multiplicand , multiplier , product);

		multiplicand = 4’ b1011 ; // 11
		multiplier = 4’ b1111 ; // 15
		#10;
		$display (" Multiplicand : %d, Multiplier : %d, Product : %d", multiplicand , multiplier , product );

		multiplicand = 4’ b1111 ; // 15
		multiplier = 4’ b1111 ; // 15
		#10;
		
		$display (" Multiplicand : %d, Multiplier : %d, Product : %d", multiplicand , multiplier , product);

		$finish ;
	end
	
endmodule

>>> endmodule

>>> begin module

// A - Modulo Multiplicador usando CSA 
// Test bench
module multiplier_testAll_tb ;
	reg [3:0] multiplicand ;
	reg [3:0] multiplier ;
	wire [7:0] product ;
	reg [7:0] expected_product ;
	integer i, j;
	reg success ;

// Instancia do multiplicador
multiplier_csa #(4) uut (
	.multiplicand ( multiplicand ) ,
	.multiplier ( multiplier ) ,
	.product ( product )
);

	initial begin
		success = 1;
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
			multiplicand = i;
			multiplier = j;
			expected_product = i * j;
			#10;
				if ( product !== expected_product ) begin
					$display (" Erro : multiplicand = %d, multiplier = %d, product = %d, expected = %d", multiplicand , multiplier , product , expected_product );
				success = 0;
				end
			end
		end

		if ( success ) begin
		$display (" Teste bem - sucedido ");
		end else begin
		$display (" Teste falhou ");
		end
		$finish ;
	end
endmodule
