
module regfile8x16c_tb;

  // Parameters

  //Ports
  reg clk;
  reg reset;
  reg write_enable;
  reg [2:0] wrAddr;
  reg [15:0] wrData;
  reg [2:0] rdAddrA;
  reg readEnA;
  wire [15:0] rdDataA;
  reg [2:0] rdAddrB;
  reg readEnB;
  wire [15:0] rdDataB;

  regfile8x16c  regfile8x16c_inst (
    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),
    .wrAddr(wrAddr),
    .wrData(wrData),
    .rdAddrA(rdAddrA),
    .readEnA(readEnA),
    .rdDataA(rdDataA),
    .rdAddrB(rdAddrB),
    .readEnB(readEnB),
    .rdDataB(rdDataB)
  );

  always #5  clk = ! clk ;

  integer i; 
  
  initial begin
    reset = 1; 
    clk = 0;
    readEnB = 0;
    readEnA = 0;

    #5; 

    write_enable = 1; 
    
    $display("---Writing data---");
    for (i = 0; i < (8); i = i + 1 ) begin
      @(posedge clk);
      wrData = i;
      wrAddr = i; 
      $display("At %t wrote the data: %b at adress: %h",$time,wrData,wrAddr);
      #5; 
    end

    write_enable = 0; 
    #5;

    $display("---Reading data---");
    for (i = 0; i < (8); i = i + 1 ) begin
      @(posedge clk);
      readEnA = $random;
      if (readEnA) begin
        rdAddrA = $random($time);
        #1; 
        $display("At %t read the data: %b from the A register at adress: %h",$time,rdDataA,rdAddrA);
      end else begin
        readEnB = 1;
        rdAddrB = $random; 
        #1;
        $display("At %t read the data: %b from the B register at adress %h",$time,rdDataB,rdAddrA);
      end
      #5;
      readEnB = 0; 
      readEnA = 0; 
    end
    $stop;

  end


endmodule