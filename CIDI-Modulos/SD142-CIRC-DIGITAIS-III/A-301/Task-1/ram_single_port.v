/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-301-T1)
Type: Laboratory
Data: febuary, 2 2026
*/

/* 
Allows data to be read from and written to 
a single memory location (address) at a time
*/

module ram_single_port #(
	parameter	DATA_WIDTH = 8,
				ADDR_WIDTH = 6
)(
	input 					clk, we,
    input  [DATA_WIDTH-1:0] data, 
    input  [ADDR_WIDTH-1:0] addr, 
    output [ADDR_WIDTH-1:0] q 
);

    reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

    reg [ADDR_WIDTH-1:0] addr_reg;
    
    always @(posedge clk) begin
    
        ram[addr] <= (we) ? data : ram[addr]; 
        addr_reg <= addr; // << ! 
    
    end

    assign q = ram[addr_reg];
    
endmodule
