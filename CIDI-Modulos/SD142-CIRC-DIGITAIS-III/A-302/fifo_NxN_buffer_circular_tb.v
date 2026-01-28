
module fifo_NxN_buffer_circular_tb;

  // Parameters
  localparam  N = 16;

  //Ports
  reg clk;
  reg reset;
  reg rd;
  reg wr;
  reg [N-1:0] w_data;
  wire full;
  wire empty;
  wire [N-1:0] r_data;

  fifo_NxN_buffer_circular # (
    .N(N)
  )
  fifo_NxN_buffer_circular_inst (
    .clk(clk),
    .reset(reset),
    .rd(rd),
    .wr(wr),
    .w_data(w_data),
    .full(full),
    .empty(empty),
    .r_data(r_data)
  );

  integer i; 

  always #5  clk = ! clk ;

  initial begin
    clk = 0; 
    reset = 1; 
    wr = 0; 
    rd = 0; 
    #5; 
    reset = 0; 

    wr = 1; 

    i = 0;

    $display("---Writing data---");

    for (i = 0; i < (17); i = i + 1 ) begin
      @(posedge clk);
      w_data = $random;
      if (!full) begin
          $display("At time %t written data: %b",$time,w_data);
      end else begin
          $display("At time %t treid to write data: %b, but buffer already full",$time,w_data);
      end
      #5; 
    end

    wr = 0; 

    $display("---Reading Data---");

    rd = 1; 
    
    for (i = 0; i < (17); i = i + 1 ) begin
      @(posedge clk);
      if (!empty) begin 
        $display("At time %t reding data: %b",$time,r_data);
      end else begin
        $display("At time %t treid to read data, but array is empty",$time);
      end
      #5; 
    end

  end


endmodule