
module moduleName_tb;

  // Parameters

  //Ports
  reg clk;
  wire reset;
  reg [7:0] data_in;
  reg start;
  wire [7:0] dataout;

  moduleName  moduleName_inst (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .start(start),
    .dataout(dataout)
  );

  always #5  clk = ! clk ;


  

endmodule