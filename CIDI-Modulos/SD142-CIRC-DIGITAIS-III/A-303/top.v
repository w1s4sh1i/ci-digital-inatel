module top (
    input clk, reset,
    input [7:0] datain,
    input dispin,
    output [7:0] dataout,
    output dispout,
    output code_err,
    output disp_err
);

    wire [9:0] dataout_encode;
    wire dispout_encode;

    reg load_shift_piso; 
    reg load_sipo;      

    reg [3:0] bit_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
            load_shift_piso <= 1'b0; 
            load_sipo <= 1'b0;       
        end else begin
            bit_counter <= bit_counter + 1;
            if (bit_counter == 0) begin
                load_shift_piso <= 1'b1;
                load_sipo <= 1'b0;
            end else if (bit_counter == 1) begin
                load_shift_piso <= 1'b0;
                load_sipo <= 1'b1;
            end else if (bit_counter == 10) begin
                load_sipo <= 1'b0;
            end
            if (bit_counter == 15) begin
                bit_counter <= 0;
            end
        end
    end

    encode_8b10b encode_8b10b_inst (
        .datain(datain),
        .dispin(dispin),
        .dataout(dataout_encode),
        .dispout(dispout_encode)
    );

    wire data_out_piso;

    PISO_reg #(.num_bits(10)) PISO_reg_inst (
        .reset(reset),
        .clk(clk),
        .load(load_shift_piso),
        .dir(1'b0), 
        .data_in(dataout_encode),
        .data_out(data_out_piso)
    );

    wire [9:0] data_out_SIPO;

    SIPO_reg #(.num_bits(10)) SIPO_reg_inst (
        .reset(reset),
        .clk(clk),
        .load(load_sipo), // Controlled by state machine
        .dir(1'b0),      // Shift left
        .data_in(data_out_piso),
        .data_out(data_out_SIPO)
    );

    wire [7:0] dataout_decode;
    wire dispout_decode;
    wire code_err_decode;
    wire disp_err_decode;

    decode_8b10b decode_8b10b_inst (
        .data_in(data_out_SIPO),
        .dispin(dispout_encode), // Note: In a real system, dispin would be tracked at the receiver
        .dataout(dataout_decode),
        .dispout(dispout_decode),
        .code_err(code_err_decode),
        .disp_err(disp_err_decode)
    );

    // Assign module outputs
    assign dataout = dataout_decode;
    assign dispout = dispout_decode;
    assign code_err = code_err_decode;
    assign disp_err = disp_err_decode;

endmodule

    
module encode_8b10b (

    input [7:0] datain,
    input dispin, // 0 = RD negativo, 1 = RD positivo
    output [9:0] dataout,
    output dispout
  );

  wire [4:0] fivebit = datain[4:0];
  wire [2:0] threebit = datain[7:5];

  reg [5:0] code5b6b_neg, code5b6b_pos;
  reg [3:0] code3b4b_neg, code3b4b_pos;

  reg [5:0] selected_5b6b;
  reg [3:0] selected_3b4b;
  // --- 5b/6b encoding ---
  always @(*)
  begin
    case (fivebit)
      5'b00000:
      begin
        code5b6b_neg = 6'b100111;
        code5b6b_pos = 6'b011000;
      end // D.0
      5'b00001:
      begin
        code5b6b_neg = 6'b011101;
        code5b6b_pos = 6'b100010;
      end
      5'b00010:
      begin
        code5b6b_neg = 6'b101101;
        code5b6b_pos = 6'b010010;
      end
      5'b00011:
      begin
        code5b6b_neg = 6'b110001;
        code5b6b_pos = 6'b110001;
      end
      5'b00100:
      begin
        code5b6b_neg = 6'b110101;
        code5b6b_pos = 6'b001010;
      end
      5'b00101:
      begin
        code5b6b_neg = 6'b101001;
        code5b6b_pos = 6'b101001;
      end
      5'b00110:
      begin
        code5b6b_neg = 6'b011001;
        code5b6b_pos = 6'b011001;
      end
      5'b00111:
      begin
        code5b6b_neg = 6'b111000;
        code5b6b_pos = 6'b000111;
      end
      default:
      begin
        code5b6b_neg = 6'b000000;
        code5b6b_pos = 6'b000000;
      end
    endcase
  end
  // --- 3b/4b encoding ---
  always @(*)
  begin
    case (threebit)
      3'b000:
      begin
        code3b4b_pos = 4'b1011;
        code3b4b_neg = 4'b0100;
      end
      3'b001:
      begin
        code3b4b_pos = 4'b1001;
        code3b4b_neg = 4'b0110;
      end
      3'b010:
      begin
        code3b4b_pos = 4'b0101;
        code3b4b_neg = 4'b1010;
      end
      3'b011:
      begin
        code3b4b_pos = 4'b1100;
        code3b4b_neg = 4'b0011;
      end
      3'b100:
      begin
        code3b4b_pos = 4'b1101;
        code3b4b_neg = 4'b0010;
      end
      3'b101:
      begin
        code3b4b_pos = 4'b1010;
        code3b4b_neg = 4'b0101;
      end
      3'b110:
      begin
        code3b4b_pos = 4'b0110;
        code3b4b_neg = 4'b1001;
      end
      3'b111:
      begin
        code3b4b_pos = 4'b1110;
        code3b4b_neg = 4'b0001;
      end
      default:
      begin
        code3b4b_pos = 4'b0000;
        code3b4b_neg = 4'b0000;
      end
    endcase
  end
  // --- Seleção em função da RD de entrada ---
  always @(*)
  begin
    if (dispin == 1'b0)
    begin
      selected_5b6b = code5b6b_neg;
      selected_3b4b = code3b4b_neg;
    end
    else
    begin
      selected_5b6b = code5b6b_pos;
      selected_3b4b = code3b4b_pos;
    end
  end

  assign dataout = {selected_5b6b, selected_3b4b};

  // --- Cálculo real da nova disparidade ---
  integer ones_count;
  always @(*)
  begin
    ones_count = selected_5b6b[0] + selected_5b6b[1] + selected_5b6b[2] +

               selected_5b6b[3] + selected_5b6b[4] + selected_5b6b[5] +
               selected_3b4b[0] + selected_3b4b[1] + selected_3b4b[2] + selected_3b4b[3];

  end

  assign dispout = (ones_count > 5) ? 1'b1 :
         (ones_count < 5) ? 1'b0 : dispin;

endmodule

module decode_8b10b (
    input [9:0] data_in,
    input dispin, // RD de entrada (para verificar a RD esperada)
    output [7:0] dataout,
    output dispout,
    output code_err,
    output disp_err
  );
  wire [5:0] abcdei = data_in[9:4]; // 5b/6b
  wire [3:0] fghj = data_in[3:0]; // 3b/4b

  reg [4:0] fivebit;
  reg [2:0] threebit;
  reg [2:0] threebit_neg;
  reg [2:0] threebit_pos;
  reg code_error;
  reg signed [3:0] disparity;

  // Decodificação reversa 5b/6b
  always @(*)
  begin
    code_error = 0;
    disparity = 0;
    case (abcdei
           )

      6'b100111:
      begin
        fivebit = 5'b00000;
        disparity =

        -2;
      end
      6'b011000:
      begin
        fivebit = 5'b00000;
        disparity = +2;
      end
      6'b011101:
      begin
        fivebit = 5'b00001;
        disparity =

        -2;
      end
      6'b100010:
      begin
        fivebit = 5'b00001;
        disparity = +2;
      end
      6'b101101:
      begin
        fivebit = 5'b00010;
        disparity =

        -2;
      end
      6'b010010:
      begin
        fivebit = 5'b00010;
        disparity = +2;
      end
      6'b110001:
      begin
        fivebit = 5'b00011;
        disparity = 0;
      end
      6'b110101:
      begin
        fivebit = 5'b00100;
        disparity =

        -2;
      end
      6'b001010:
      begin
        fivebit = 5'b00100;
        disparity = +2;
      end
      6'b101001:
      begin
        fivebit = 5'b00101;
        disparity = 0;
      end
      6'b011001:
      begin
        fivebit = 5'b00110;
        disparity = 0;
      end
      6'b111000:
      begin
        fivebit = 5'b00111;
        disparity =

        -2;
      end
      6'b000111:
      begin
        fivebit = 5'b00111;
        disparity = +2;
      end
      default:
      begin
        fivebit = 5'b00000;
        code_error = 1;
        disparity = 0;
      end
    endcase
  end

  // Decodificação reversa 3b/4b
  always @(*)
  begin
    case (fghj)
      4'b1011:
      begin
        threebit = 3'b000;
        disparity = disparity - 1;
      end
      4'b0100:
      begin
        threebit = 3'b000;
        disparity = disparity + 1;
      end
      4'b1001:
      begin
        threebit_neg = 3'b001;
        threebit_pos = 3'b110;
        disparity = disparity - 1;
      end
      4'b0110:
      begin
        threebit_neg = 3'b001;
        threebit_pos = 3'b110;
        disparity = disparity + 1;
      end
      4'b0101:
      begin
        threebit_neg = 3'b010;
        threebit_pos = 3'b101;
        disparity = disparity - 1;
      end
      4'b1010:
      begin
        threebit_neg = 3'b010;
        threebit_pos = 3'b101; 
        disparity = disparity + 1;
      end
      4'b1100:
      begin
        threebit = 3'b011;
        disparity = disparity - 1;
      end
      4'b0011:
      begin
        threebit = 3'b011;
        disparity = disparity + 1;
      end
      4'b1101:
      begin
        threebit = 3'b100;
        disparity = disparity - 1;
      end
      4'b0010:
      begin
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
      4'b1110:
      begin
        threebit = 3'b111;
        disparity = disparity - 1;
      end
      4'b0001:
      begin
        threebit = 3'b111;
        disparity = disparity + 1;
      end
      default:
      begin
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


module PISO_reg #(parameter num_bits = 10) (
    input wire reset,
    input wire clk,
    input wire load,
    input wire dir,
    input wire [num_bits-1:0] data_in,
    output wire data_out
  );
  // Registrador interno
  reg [num_bits-1:0] reg_data = 0;
  // Saída serial
  assign data_out = (dir == 1'b0) ? reg_data[0] : reg_data[num_bits-1];
  // Lógica sequencial
  always @(posedge clk or posedge reset)
  begin
    if (reset)
    begin
      reg_data <= 0; // Reset
    end
    else if

    (load)
    begin
      reg_data <= data_in; // Carrega o dado paralelo
    end
    else if

    (dir)
    begin
      // Shift à esquerda (insere zero à direita)
      reg_data <= {reg_data[num_bits-2:0], 1'b0};

    end
    else
    begin
      // Shift à direita (insere zero à esquerda)
      reg_data <= {1'b0, reg_data[num_bits-1:1]};
    end
  end
endmodule

module SIPO_reg #(parameter num_bits = 10) (
    input wire reset,
    input wire clk,
    input wire load, // Quando load = 1, permite capturar novo dado serial
    input wire dir, // Direção de deslocamento (0 = shift para direita, 1 = shift para esquerda)
    input wire data_in, // Entrada serial
    output reg [num_bits-1:0] data_out // Saída paralela
  );

  always @(posedge clk or posedge reset)
  begin
    if (reset)
    begin
      data_out <= 0; // Reset
    end
    else if (load)
    begin
      if (dir)
      begin
        // Shift à esquerda: desloca e insere o bit serial no LSB
        data_out <= {data_out[num_bits-2:0], data_in};
      end
      else
      begin
        // Shift à direita: desloca e insere o bit serial no MSB
        data_out <= {data_in, data_out[num_bits-1:1]};
      end
    end
  end
endmodule
