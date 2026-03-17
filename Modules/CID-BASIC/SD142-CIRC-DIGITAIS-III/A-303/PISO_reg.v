/* header */

module PISO_reg #(parameter BITS_NUM = 10) (
    input reset, clk, load, dir,
    input [BITS_NUM-1:0] data_in,
    output data_out
  );
  // Registrador interno
  reg [BITS_NUM-1:0] reg_data = {BITS_NUM{1'b0}};
  // Saída serial
  assign data_out = (dir == 1'b0) ? reg_data[0] : reg_data[BITS_NUM-1];
  // Lógica sequencial
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      reg_data <= {BITS_NUM{1'b0}}; // Reset
    end
    else if (load) begin
      reg_data <= data_in; // Carrega o dado paralelo
    end
    else if (dir) begin
      // Shift à esquerda (insere zero à direita)
      reg_data <= {reg_data[BITS_NUM-2 : 0], 1'b0};
    end
    else begin
      // Shift à direita (insere zero à esquerda)
      reg_data <= {1'b0, reg_data[BITS_NUM-1 : 1]};
    end
  end
  
endmodule
