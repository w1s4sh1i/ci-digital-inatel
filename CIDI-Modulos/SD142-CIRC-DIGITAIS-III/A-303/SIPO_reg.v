/* header */

module SIPO_reg #(parameter BITS_NUM = 10) (

    input reset, clk, load, dir, data_in,
    // Quando load = 1, permite capturar novo dado serial
    // Direção de deslocamento (0 = shift para direita, 1 = shift para esquerda)
    // Entrada serial
    output [BITS_NUM-1:0] data_out 
    // Saída paralela
  );

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= 0; // Reset
    end
    else if (load) begin
      if (dir) begin
        // Shift à esquerda: desloca e insere o bit serial no LSB
        data_out <= {data_out[BITS_NUM-2 : 0], data_in};
      end
      else begin
        // Shift à direita: desloca e insere o bit serial no MSB
        data_out <= {data_in, data_out[BITS_NUM-1 : 1]};
      end
      
    end
    
  end
  
endmodule
