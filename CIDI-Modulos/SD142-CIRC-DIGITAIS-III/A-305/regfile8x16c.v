module regfile8x16c (
    input clk,
    input reset,
    input write_enable,
    input [2:0] wrAddr,
    input [15:0] wrData,
    input [2:0] rdAddrA,
    input readEnA,
    output [15:0] rdDataA,
    input [2:0] rdAddrB,
    input readEnB,
    output [15:0] rdDataB
  );
  // 8 registradores de 16 bits
  reg [15:0] regfile [0:7];
  // Leitura condicional com read enable
  assign rdDataA = (readEnA) ? regfile[rdAddrA] : 16'bz;
  assign rdDataB = (readEnB) ? regfile[rdAddrB] : 16'bz;
  integer i;
  always @(posedge clk)
  begin
    if (reset)
    begin
      for (i = 0; i < 8; i = i + 1)
      begin
        regfile[i] <= 0;
      end
    end
    else
    begin
      if (write_enable)
      begin
        regfile[wrAddr] <= wrData;
      end
    end
  end
endmodule
