module decoder_tb;

  reg clk;
  reg reset;
  reg 


  decode_8b10b  decode_8b10b_inst (
                  .data_in(data_out_sipo),
                  .dispin(dispout_encode),
                  .dataout(dataout_decode),
                  .dispout(dispout_decode),
                  .code_err(code_err_decode),
                  .disp_err(disp_err_decode)
                );




  always #5  clk = ! clk;

  initial
  begin
    reset <= 1;
    clk <= 0;
    #10;

    reset <= 0;
    load <= 1;
    datain <= 8'b00011100;
    dispin = 1;
    #5;
    load <= 0;
  end


endmodule




