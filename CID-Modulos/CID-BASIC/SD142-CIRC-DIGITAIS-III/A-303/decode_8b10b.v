/* header */

module decode_8b10b (
    input	[9:0] data_in,
    input	dispin, 			// RD de entrada (para verificar a RD esperada)
    output	[7:0] dataout,
    output	dispout, code_err, disp_err
  );
  wire [5:0] abcdei = data_in[9:4]; // 5b/6b
  wire [3:0] fghj = data_in[3:0]; // 3b/4b

  reg [4:0] fivebit;
  reg [2:0] threebit, threebit_neg, threebit_pos;
  reg code_error;
  reg signed [3:0] disparity;

  // Decodificação reversa 5b/6b
  always @(*) begin
    code_error = 1'b0;
    disparity = 4'b0000;
    case (abcdei)
      6'b100111: begin
        fivebit = 5'b00000;
        disparity = -2;
      end
      6'b011000: begin
        fivebit = 5'b00000;
        disparity = +2;
      end
      6'b011101: begin
        fivebit = 5'b00001;
        disparity = -2;
      end
      6'b100010: begin
        fivebit = 5'b00001;
        disparity = +2;
      end
      6'b101101: begin
        fivebit = 5'b00010;
        disparity = -2;
      end
      6'b010010: begin
        fivebit = 5'b00010;
        disparity = +2;
      end
      6'b110001: begin
        fivebit = 5'b00011;
        disparity = 0;
      end
      6'b110101: begin
        fivebit = 5'b00100;
        disparity = -2;
      end
      6'b001010: begin
        fivebit = 5'b00100;
        disparity = +2;
      end
      6'b101001: begin
        fivebit = 5'b00101;
        disparity = 0;
      end
      6'b011001: begin
        fivebit = 5'b00110;
        disparity = 0;
      end
      6'b111000: begin
        fivebit = 5'b00111;
        disparity = -2;
      end
      6'b000111: begin
        fivebit = 5'b00111;
        disparity = +2;
      end
      default: begin
        fivebit = 5'b00000;
        code_error = 1;
        disparity = 0;
      end
    endcase
  end

  // Decodificação reversa 3b/4b
  always @(*) begin
    case (fghj)
      4'b1011: begin
        threebit = 3'b000;
        disparity = disparity - 1;
      end
      4'b0100: begin
        threebit = 3'b000;
        disparity = disparity + 1;
      end
      4'b1001: begin
        threebit_neg = 3'b001;
        threebit_pos = 3'b110;
        disparity = disparity - 1;
      end
      4'b0110: begin
        threebit_neg = 3'b001;
        threebit_pos = 3'b110;
        disparity = disparity + 1;
      end
      4'b0101: begin
        threebit_neg = 3'b010;
        threebit_pos = 3'b101;
        disparity = disparity - 1;
      end
      4'b1010: begin
        threebit_neg = 3'b010;
        threebit_pos = 3'b101; 
        disparity = disparity + 1;
      end
      4'b1100: begin
        threebit = 3'b011;
        disparity = disparity - 1;
      end
      4'b0011: begin
        threebit = 3'b011;
        disparity = disparity + 1;
      end
      4'b1101: begin
        threebit = 3'b100;
        disparity = disparity - 1;
      end
      4'b0010: begin
        threebit = 3'b100;
        disparity = disparity + 1;
      end
      // 4'b1010:
      // begin
      //   threebit = 3'b101;
      //   disparity = disparity + 1;
      // end
      // 4'b0101:
      // begin
      //   
      //   disparity = disparity - 1;
      // end
      // 4'b0110:
      // begin
      //   
      //   ///////////
      //   disparity = disparity + 1;
      // end
      // 4'b1001:
      // begin
      //   threebit = 3'b110;
      //   disparity = disparity - 1;
      // end
      4'b1110: begin
        threebit = 3'b111;
        disparity = disparity - 1;
      end
      4'b0001: begin
        threebit = 3'b111;
        disparity = disparity + 1;
      end
      default: begin
        threebit = 3'b000;
        code_error = 1;
      end
    endcase
  end

  always @(*) begin
    if (!dispin && |threebit_neg) begin
      threebit = threebit_neg; 
    end else begin
      threebit = threebit; 
    end
  end

  assign dataout = {threebit, fivebit};

  // Cálculo da nova disparidade de saída (pode ser usado para controle externo de RD)
  assign dispout = (disparity > 0) ? 1'b1 : (disparity < 0) ? 1'b0 : dispin;

  // Verificação de erro de disparidade
  assign disp_err = ((dispin == 0 && disparity > 0) || (dispin == 1 && disparity < 0)) ? 1'b1 : 1'b0;
  assign code_err = code_error;

endmodule
