/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/<challenge title>

// Vector1
module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 16)( 
	input wire [WIDTH_MAX-1:0] in,
	output wire [WIDTH_MIN-1:0] out_hi,
	output wire [WIDTH_MIN-1:0] out_lo
);
	assign out_lo = in[WIDTH_MIN-1:0];
	assign out_hi = in[WIDTH_MAX-1:WIDTH_MIN];
	// assign (out_lo, out_hi) = in; 
endmodule

// Vector2

module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 32)( 
    input [WIDTH_MAX-1:0] in,
    output [WIDTH_MAX-1:0] out
);
	
    assign out[4*WIDTH_MIN -1 : 3*WIDTH_MIN ] = in[1*WIDTH_MIN -1 : 0*WIDTH_MIN];
    assign out[3*WIDTH_MIN -1 : 2*WIDTH_MIN ] = in[2*WIDTH_MIN -1 : 1*WIDTH_MIN];
    assign out[2*WIDTH_MIN -1 : 1*WIDTH_MIN ] = in[3*WIDTH_MIN -1 : 2*WIDTH_MIN];
    assign out[1*WIDTH_MIN -1 : 0*WIDTH_MIN ] = in[4*WIDTH_MIN -1 : 3*WIDTH_MIN];
    /*
    assign out[31:24] = in[7:0];
    assign out[23:16] = in[15:8];
    assign out[15:8] = in[23:16];
    assign out[7:0] = in[31:24];
    */

endmodule

// Vectorgates

module top_module #(parameter WIDTH_MIN = 3, WIDTH_MAX = 6)( 
    input [WIDTH_MIN-1:0] a, b,
    output out_or_logical,
    output [WIDTH_MIN-1:0] out_or_bitwise,
    output [WIDTH_MAX-1:0] out_not
);
    assign out_or_bitwise = a | b;
    assign out_or_logical = a || b;
    assign out_not[WIDTH_MIN-1:0] = ~a;
    assign out_not[WIDTH_MAX-1:WIDTH_MIN] = ~b;
    
endmodule

// Gates4

module top_module #(parameter WIDTH = 4)( 
    input [WIDTH-1:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // and a1 (out_and, in[0], in[1], in[2], in[3]);
    assign out_and = &in;  
    // or o1 (out_or, in[0], in[1], in[2], in[3]);
    assign out_or = |in;
    // xor xr1 (out_xor, in[0], in[1], in[2], in[3]);
    assign out_xor = ^in;
    
endmodule

// Vector3

module top_module #(parameter WIDTH_MIN = 5, WIDTH_MAX = 8, ADDITION = 2'b11)(
    input [WIDTH_MIN - 1:0] a, b, c, d, e, f,
    output [WIDTH_MAX - 1:0] w, x, y, z 
);
    assign {w, x, y, z} = {a, b, c, d, e, f, ADDITION};

endmodule

// Vectorr

module top_module #(parameter WIDTH = 8)( 
    input [WIDTH-1 :0] in,
    output [WIDTH-1 :0] out
);
    always @(*) begin
        for(integer i = 0; i < WIDTH; ++i) begin
            out[WIDTH-1-i] <= in[i];
        end    
    end     
endmodule

// Vector100r

module top_module #(parameter WIDTH = 100)( 
    input [WIDTH-1 :0] in,
    output [WIDTH-1 :0] out
);
    always @(*) begin
        for(integer i = 0; i < WIDTH; ++i) begin
            out[WIDTH-1-i] <= in[i];
        end    
    end     
endmodule

// Vector4

module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 32, COPIES = 24)(
    input [WIDTH_MIN-1 : 0] in,
    output [WIDTH_MAX-1 : 0] out
);
    assign out = { { COPIES{in[WIDTH_MIN-1]} }, in};

endmodule

// Vector5

module top_module #(parameter WIDTH_MIN = 5, WIDTH_MAX = 25, REPEAT = WIDTH_MAX / WIDTH_MIN)(
    input a, b, c, d, e,
    output [WIDTH_MAX-1 : 0] out 
);
    wire [WIDTH_MIN-1 : 0] data_in = {a, b, c, d, e};
    
    genvar i;
    generate
        for (i = 0; i < WIDTH_MIN; i = i + 1) begin : rep_block
            assign out[WIDTH_MIN*(i+1)-1 : WIDTH_MIN*i] = ~{REPEAT{data_in[i]}} ^ data_in; 
        end
    endgenerate                            

endmodule

// Module

module top_module ( 
    input a, b, 
    output out
);
    mod_a instance1 ( .in1(a), .in2(b), .out(out) );

endmodule

// Module pos

module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a (out1, out2, a, b, c, d);
    
endmodule

// Dff

module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q 
);//

    always @(posedge clk) begin
        q = d;  
    end 
endmodule

// Dff8

// Apenas o ffd já seria uma boa resposta.
module ffd (
    	input clk, d,
        output q
);
    always @(posedge clk) begin
        q <= d;
    end 
endmodule

module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : my_block_gen
            ffd (clk, d[i], q[i]);
        end
    endgenerate
endmodule

// Dff8r

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        q <= (reset) ? 8'b0 : d; 
    end 
endmodule

// 


