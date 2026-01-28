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
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps 

module demux1x8 (
    input 			  sel,
    input 		[2:0] addr,
    input 		 	  in,
    output reg	[7:0] out
);
    always @(*) begin
        // out = 8'b0; 
		// out[addr] = in & sel;
        if (sel) begin
            case (addr)
            	// out = {(WIDTH-addr){1'b0}, in, addr{1'b0}};
                3'b000: out = {{7{1'b0}},in};
                3'b001: out = {{6{1'b0}},in,{1{1'b0}}};
                3'b010: out = {{5{1'b0}},in,{2{1'b0}}};
                3'b011: out = {{4{1'b0}},in,{3{1'b0}}};
                3'b100: out = {{3{1'b0}},in,{4{1'b0}}};
                3'b101: out = {{2{1'b0}},in,{5{1'b0}}};
                3'b110: out = {{1{1'b0}},in,{6{1'b0}}};
                3'b111: out = {in,{7{1'b0}}};
                default: out = 8'b0; // Safety default
            endcase
        end else begin
			out = 8'b0; // Default all outputs to 0
        end
    end
    
endmodule
