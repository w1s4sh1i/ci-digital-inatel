module encoder_tb;

  reg clk;
  reg reset;
  reg [7:0] datain;
  reg dispin;

  wire [9:0] dataout_encode;
  wire dispout_encode;
  reg load; 


  encode_8b10b  encode_8b10b_inst (
                  .datain(datain),
                  .dispin(dispin),
                  .dataout(dataout_encode),
                  .dispout(dispout_encode)
                );

  wire data_out_piso;

  PISO_reg # (
             .num_bits(10)
           )
           PISO_reg_inst (
             .reset(reset),
             .clk(clk),
             .load(load),
             .dir(1'b1),
             .data_in(dataout_encode),
             .data_out(data_out_piso)
           );

  always #5  clk = ! clk;

  integer i; 

  initial
  begin
    reset <= 1;
    clk <= 0;
    #10;
    reset <= 0;
    load <= 1; 
    datain <= 8'b00011100;
    dispin = 0;
    #5; 
    load <= 0; 
  end


endmodule




