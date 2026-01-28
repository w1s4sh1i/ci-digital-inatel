/*

    1 - Apenas um ciclo de clock

    2 - Para que seja possivel trabalhar com números maiores, já que a saída de uma múltiplicação entre dois números de 8 bits é 16 bits.

    3 - 66051 operações

*/


module MAC(
    input clk ,
    input rst ,
    input [7:0] A,
    input [7:0] B,
    output [ 31 : 0 ] result
  ) ;
  wire signed [15:0] product ;
  wire signed [31:0] sum;
  reg signed [31:0] accumulator;

  assign product = $signed(A)*$signed(B) ; // M ul ti pli c a d o r
  assign sum = accumulator + product ; // Somador

  always @( posedge clk or posedge rst )
  begin
    if ( rst )
      accumulator <= 0 ;
    else if (en) begin
        accumulator <= sum ; // Acumulador
    end
  end

  assign result = accumulator ; // Sa í da do acumulador

endmodule
