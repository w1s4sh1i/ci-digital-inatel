/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
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

module demux_1x8_tb(); 
    
    localparam DELAY = 10; 
    reg sel;
    reg [2:0] addr;
    reg in;
    wire [7:0] out;

    demux_1x8 uut (
        .sel(sel),
        .addr(addr),
        .in(in),
        .out(out)
    );

    initial begin

        $dumpfile("CID-SD122-A106-1.vcd");
        $dumpvars(0, demux_1x8_tb);

		$display("|Sel	|Addr	|In	|Out	|");
		$monitor("|%b	|%b	|%b	|%b	|", sel, addr, in, out);

        // Test case 1: sel = 0, all outputs should be 0
        sel = 0; 
        addr = 3'b000; in = 1'b1;
        #DELAY;

        // Test case 2: sel = 1, addr = 3'b000
        sel = 1'b1; 
        addr = 3'b000;
        in = 1'b1;
        #DELAY;

        // Test case 3: sel = 1, addr = 3'b101

        addr = 3'b101;
        in = 1'b1;
        #DELAY;

        // Test case 4: sel = 1, addr = 3'b111
        
        addr = 3'b111;
        in = 1'b1;
        #DELAY;

        // Test case 5: sel = 1, addr = 3'b010, in = 0 
        addr = 3'b010; 
        in = 1'b0;
        #DELAY;

        $finish;
    end


endmodule
