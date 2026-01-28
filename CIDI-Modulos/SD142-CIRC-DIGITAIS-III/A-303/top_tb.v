
module top_tb;

  // Parameters

  //Ports
  reg clk; 
  reg reset;
  reg load; 
  reg [7:0] datain;
  reg dispin;
  wire [7:0] dataout;
  wire dispout;
  wire code_err;
  wire disp_err;

  top  top_inst (
    .clk(clk),
    .reset(reset),
    .datain(datain),
    .dispin(dispin),
    .dataout(dataout),
    .dispout(dispout),
    .code_err(code_err),
    .disp_err(disp_err)
  );

  always #5  clk = ! clk;
  always @(posedge clk) begin
    if (top_inst.datain == top_inst.dataout) begin
      $display("At time: %t datain: %b dataout: %b ",$time,datain,dataout); 
    end
  end

  initial begin
    reset <= 1; 
    clk <= 0;
    #5; 

    reset <= 0; 
    datain <= 8'b011_00010; 
    dispin = 0; 
    #5; 
    #500;
    datain <= 8'b000_00000; 
    #500; 
    datain <= 8'b000_10101; 
    #500;
    $stop;
    
  end

endmodule