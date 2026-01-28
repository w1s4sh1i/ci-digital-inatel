/*
    Exercício 1:
        Eles se diferenciam na quantidade de caminhos disponiveis de suas interconecções. 
    Exercício 2: 
        Tratar solicitações simultâneas a um recurso compartilhado. 
    Exercício 3: 
        Solicitações de duas entradas para a mesmo recurso em uma chamada não são possiveis.
*/



module crossbar_switch_4x4 (
    input wire [1:0] select , // S i n a l de c o n t r o l e de 2 b i t s para s e l e c i o n a r a conex ão
    input wire [7:0] in1 , in2 , in3 , in4 , // Entradas de 8 b i t s
    output reg [7:0] out1 , out2 , out3 , out4 // Sa í das de 8 b i t s
  ) ;

  always @(*)
  begin
    // Conexão da en t rada para a sa í da baseada no s i n a l de s e l e ç ão
    case ( select )
      2'b00 :
      begin
        out1 = in1 ;
        out2 = in2 ;
        out3 = in3 ;
        out4 = in4 ;
      end
      2'b01 :
      begin
        out1 = in2 ;
        out2 = in1 ;
        out3 = in4 ;
        out4 = in3 ;
      end
      2'b10 :
      begin
        out1 = in3 ;
        out2 = in4 ;
        out3 = in1 ;
        out4 = in2 ;
      end
      2'b11 :
      begin
        out1 = in4 ;
        out2 = in3 ;
        out3 = in2 ;
        out4 = in1 ;
      end
      default :
      begin
        out1 = 8'h00 ;
        out2 = 8'h00 ;
        out3 = 8'h00 ;
        out4 = 8'h00 ;
      end
    endcase
  end

endmodule



module crossbar_switch_4x4_tb;

  // Parameters

  //Ports
  reg [1:0] select;
  reg [7:0] in1, in2, in3, in4;
  wire [7:0] out1, out2, out3, out4;

  crossbar_switch_4x4  crossbar_switch_4x4_inst (
                         .select(select),
                         .in1(in1),
                         .in2(in2),
                         .in3(in3),
                         .in4(in4),
                         .out1(out1),
                         .out2(out2),
                         .out3(out3),
                         .out4(out4)
                       );

  task expect;
    input [31:0] expected_out;
    if ({out1,out2,out3,out4} !== expected_out)
    begin
      $display("TEST FAILED");
      $display("At time %0d out=%b",
               $time, {out1,out2,out3,out4});
      $display("out should be %b", expected_out);
      //$finish;
    end
    else
    begin
      $display("At time %0d out=%b",
               $time, {out1,out2,out3,out4});

    end
  endtask

  initial
  begin
    select = 0;
    in1 = $random ;in2 = $random ;in3 = $random ;in4 = $random ;
    #1;
    expect({in1,in2,in3,in4});
    #5;
    select = 1;
    in1 = $random ;in2 = $random ;in3 = $random ;in4 = $random ;
    #1;
    expect({in2,in1,in4,in3});
    #5;
    select = 2;
    in1 = $random ;in2 = $random ;in3 = $random ;in4 = $random ;
    #1;
    expect({in3,in4,in1,in2});
    #5;
    select = 3;
    in1 = $random ;in2 = $random ;in3 = $random ;in4 = $random ;
    #1;
    expect({in4,in3,in2,in1});
    #5;
    $stop;
  end
endmodule
