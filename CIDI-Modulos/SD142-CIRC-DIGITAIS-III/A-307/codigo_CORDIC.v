`timescale 1 ns/100 ps



module cordic_serial_abs #(
   parameter WIDTH = 16
)(
   input clk,
   input rst,
   input [WIDTH-1:0] data_X,
   input [WIDTH-1:0] data_Y,
   input [WIDTH-1:0] data_Z,
   output [WIDTH-1:0] abs,
   output [WIDTH-1:0] tan
);
   localparam [11:0] INV_CORDIC_GAIN = 12'b010011011011;
   localparam [11:0] INV_CORDIC_GAIN_N = 12'b101100100101;

   wire signed [WIDTH+11:0] multiplier_out;
   wire signed [11:0] correction_gain;
   wire signed [WIDTH-1:0] mux_X, mux_Y, feedback_X, feedback_Y,mux_Z,feedback_Z;
   reg signed [WIDTH-1:0] reg_X, reg_Y, shift_X, shift_Y,reg_Z;
   reg signed [2:0] iter_counter;
   wire signed [2:0] iter_val;
   wire sign, clear;
   reg select;
    localparam [11:0] CORDIC_ANGLES [0:7] = '{
        12'b110010010001,  // For iter_val=0 (45 degrees)
        12'b011101101100,  // For iter_val=1 (26.565 degrees)
        12'b001111101100,  // For iter_val=2 (14.036 degrees)
        12'b000111111101,  // For iter_val=3 (7.125 degrees)
        12'b000100000000,  // For iter_val=4 (3.576 degrees)
        12'b000010000000,  // For iter_val=5 (1.789 degrees)
        12'b000001000000,  // For iter_val=6 (0.895 degrees)
        12'b000000100000   // For iter_val=7 (0.447 degrees)
    };

   /* Input muxes */
   assign mux_X = select ? feedback_X : data_X;
   assign mux_Y = select ? feedback_Y : data_Y;
   assign mux_Z = select ? feedback_Z : data_Z; 

   /* Registers */
   always @(posedge clk) begin
      if (rst | clear) begin
         reg_X <= 0;
         reg_Y <= 0;
         reg_Z <= 0; 
      end else begin
         reg_X <= mux_X;
         reg_Y <= mux_Y;
         reg_Z <= mux_Z; 
      end
   end

   /* Shift registers*/
   always @(*) begin
      shift_X <= reg_X >>> iter_val;
      shift_Y <= reg_Y >>> iter_val;
   end

   /* Adders (sign inverted for ADD_X vs ADD_Y)*/
   assign feedback_X = sign ? reg_X - shift_Y : reg_X + shift_Y;
   assign feedback_Y = !sign ? reg_Y - shift_X : reg_Y + shift_X;
   assign feedback_Z = sign ? reg_Z + CORDIC_ANGLES[iter_counter] : reg_Z - CORDIC_ANGLES[iter_counter];


   /* Sign computation = MSB(reg_X) XOR MSB(reg_Y) */
   assign sign = reg_X[WIDTH-1] ^ reg_Y[WIDTH-1];

   /* Ensure abs is positive (force 1st quadrant) */
   //assign abs = !feedback_X[WIDTH-1] ? feedback_X : (!feedback_X) + 1;  

   /* Correct cordic gain and ensure 1st quadrant */
   assign correction_gain = feedback_X[WIDTH-1] ? INV_CORDIC_GAIN_N : INV_CORDIC_GAIN;
   assign multiplier_out = correction_gain * feedback_X;
   assign abs = multiplier_out[WIDTH+10:11];
   assign tan = feedback_Z; 

   /* CORDIC serial control - counter */
   always @(posedge clk) begin
      if (rst) begin
         iter_counter <= 3'd7;
      end else begin
         select <= !clear;
         iter_counter <= iter_counter + 1;
      end
   end

   assign iter_val = iter_counter - 1;
   assign clear = (iter_counter == 3'd7) ? 1'b1 : 1'b0;

endmodule

`include "lib_testbench.v"
module tb_cordic;
   localparam real FREQUENCY = 100e6;      // Clock frequency in Hz

   reg        clk;
   reg         rst;
   reg  [15:0] X, Y,Z;
   wire [15:0] abs;
   wire [15:0] tan; 

   always #5  clk = ! clk ;

   always @(posedge clk) begin
      if (cordic.iter_val == 6) begin // Check the condition
         $display("Abs value for X:%d , Y:%d is abs:%d at time %0t", X, Y, abs, $time); 
      end
   end

   /* Initialization of simulation values and reset */
   initial begin
      clk <= 0;
      rst <= 1;       // initiate with reset asserted
      #20 rst = 0;    // release reset
      X <= 16'd31;
      Y <= 16'd63;
      Z <= 0; 
      #200 X <= 16'd100; Y <= 16'd100;
      #200 X <= 16'd287; Y <= 16'd31;
      #200 X <= 16'd152; Y <= 16'd358;
      #200 X <= 16'd181; Y <= 16'd500;
      #200;
      $stop; 
   end

  // 100 + 100j, 287 − 31j, −152 − 358j e −181 + 500j.
   /* Clock generators for the testbench - defines frequency and initial polarity */
   //clock_generator #(FREQUENCY, 1) CLOCK100M(.clk(clk));

   cordic_serial_abs #(16) cordic(.clk(clk), .rst(rst), .data_X(X), .data_Y(Y),.data_Z(Z), .abs(abs),.tan(tan));

endmodule