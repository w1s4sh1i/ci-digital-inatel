/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux_8x1_tb;

    reg  [7:0] in; 
    reg  [2:0] sel;  
    wire       out;

    mux_8x1 U1 (
        .in(in),
        .sel(sel),
        .out(out)
    );

    task mux;
        integer i;
        
     begin

        for (i = 0; i < 8; i = i + 1) begin
            in  = 8'b00000000;  
            in[i] = 1'b1;        
            sel = i;             
            #10;  
            
        end

 
     end

    endtask


   	initial begin

        sel = 3'b0;
        in = 8'b0;
        #5;

        mux;

        #10;
       $finish; 
    end

endmodule
