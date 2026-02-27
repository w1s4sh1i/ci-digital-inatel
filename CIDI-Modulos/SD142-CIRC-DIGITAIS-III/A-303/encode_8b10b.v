/* header */

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
  always @(*) begin
    case (fivebit)
      5'b00000: begin
        code5b6b_neg = 6'b100111;
        code5b6b_pos = 6'b011000;
      end // D.0
      5'b00001: begin
        code5b6b_neg = 6'b011101;
        code5b6b_pos = 6'b100010;
      end
      5'b00010: begin
        code5b6b_neg = 6'b101101;
        code5b6b_pos = 6'b010010;
      end
      5'b00011: begin
        code5b6b_neg = 6'b110001;
        code5b6b_pos = 6'b110001;
      end
      5'b00100: begin
        code5b6b_neg = 6'b110101;
        code5b6b_pos = 6'b001010;
      end
      5'b00101: begin
        code5b6b_neg = 6'b101001;
        code5b6b_pos = 6'b101001;
      end
      5'b00110: begin
        code5b6b_neg = 6'b011001;
        code5b6b_pos = 6'b011001;
      end
      5'b00111: begin
        code5b6b_neg = 6'b111000;
        code5b6b_pos = 6'b000111;
      end
      default: begin
        code5b6b_neg = 6'b000000;
        code5b6b_pos = 6'b000000;
      end
    endcase
    
  end
  // --- 3b/4b encoding ---
  always @(*) begin
    case (threebit)
      3'b000: begin
        code3b4b_pos = 4'b1011;
        code3b4b_neg = 4'b0100;
      end
      3'b001: begin
        code3b4b_pos = 4'b1001;
        code3b4b_neg = 4'b0110;
      end
      3'b010: begin
        code3b4b_pos = 4'b0101;
        code3b4b_neg = 4'b1010;
      end
      3'b011: begin
        code3b4b_pos = 4'b1100;
        code3b4b_neg = 4'b0011;
      end
      3'b100: begin
        code3b4b_pos = 4'b1101;
        code3b4b_neg = 4'b0010;
      end
      3'b101: begin
        code3b4b_pos = 4'b1010;
        code3b4b_neg = 4'b0101;
      end
      3'b110: begin
        code3b4b_pos = 4'b0110;
        code3b4b_neg = 4'b1001;
      end
      3'b111: begin
        code3b4b_pos = 4'b1110;
        code3b4b_neg = 4'b0001;
      end
      default: begin
        code3b4b_pos = 4'b0000;
        code3b4b_neg = 4'b0000;
      end
    endcase
  end
  // --- Seleção em função da RD de entrada ---
  always @(*) begin
    if (dispin == 1'b0) begin
      selected_5b6b = code5b6b_neg;
      selected_3b4b = code3b4b_neg;
    end else begin
      selected_5b6b = code5b6b_pos;
      selected_3b4b = code3b4b_pos;
    end
  end

  assign dataout = {selected_5b6b, selected_3b4b};

	// --- Cálculo real da nova disparidade ---
	integer ones_count;
  
	always @(*) begin
	ones_count =	selected_5b6b[0] + selected_5b6b[1] + selected_5b6b[2] +
		       		selected_5b6b[3] + selected_5b6b[4] + selected_5b6b[5] +
		      		selected_3b4b[0] + selected_3b4b[1] + selected_3b4b[2] + selected_3b4b[3];
	end

	assign dispout =	(ones_count > 5) ? 1'b1 :
		 				(ones_count < 5) ? 1'b0 : dispin;

endmodule
