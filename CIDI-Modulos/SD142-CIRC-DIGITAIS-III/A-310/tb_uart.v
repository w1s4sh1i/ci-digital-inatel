`timescale 1ns / 1ps

module tb_uart;

  reg  clk;
  reg  reset;

  // RX Data
  //reg  rx;
  wire [7:0] data_out;
  wire rx_done;


  // TX Data
  reg [7:0] data_in;
  reg  tx_start;
  wire tx;
  wire tx_done;

  uart_tx  uart_tx_inst (
             .clk(clk),
             .reset(reset),
             .data_in(data_in),
             .tx_start(tx_start),
             .tx(tx),
             .tx_done(tx_done)
           );


  uart_rx  uart_rx_inst (
             .clk(clk),
             .reset(reset),
             .rx(tx),
             .data_out(data_out),
             .rx_done(rx_done)
           );


  always #5 clk = ~clk;

  initial
  begin
    clk = 0;
    reset = 0;
  end

  integer i;
  initial
  begin
    #20;
    reset = 1;
    #20;
    reset = 0;

    for (i = 0; i < 5; i = i+1)
    begin
      data_in <= $random;
      @(posedge clk);
      tx_start <= 1;
      @(posedge clk);
      tx_start <= 0;

      while (tx_done !== 1'b1)
        @(posedge clk);

      while (rx_done !== 1'b1)
        @(posedge clk);

      while (tx_done !== 1'b0 || rx_done !== 1'b0)
        @(posedge clk);

      $display("Time = %0t, start = %b, data_in = %b, data_out= %b ",
               $time, tx_start, data_in, data_out);

      #500;


    end
    #100;
    $stop;
  end


endmodule

