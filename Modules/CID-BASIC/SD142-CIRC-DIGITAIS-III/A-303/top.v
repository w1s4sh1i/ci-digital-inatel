/* header */

module top (
    input clk, reset, dispin,
    input [7:0] datain,
    output [7:0] dataout,
    output dispout, code_err, disp_err
);

    wire [9:0] dataout_encode;
    wire dispout_encode;

    reg load_shift_piso; 
    reg load_sipo;      

    reg [3:0] bit_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 4'b0;
            load_shift_piso <= 1'b0; 
            load_sipo <= 1'b0;       
        end else begin
            bit_counter <= bit_counter + 1;
            if (bit_counter == 4'b0000) begin
                load_shift_piso <= 1'b1;
                load_sipo <= 1'b0;
            end else if (bit_counter == 4'b0001) begin
                load_shift_piso <= 1'b0;
                load_sipo <= 1'b1;
            end else if (bit_counter == 4'b0010) begin
                load_sipo <= 1'b0;
            end
            if (bit_counter == 4'b1111) begin
                bit_counter <= 4'b0;
            end
        end
    end

endmodule

// >>> top level
  encode_8b10b encode_8b10b_inst (
        .datain(datain),
        .dispin(dispin),
        .dataout(dataout_encode),
        .dispout(dispout_encode)
    );

    wire data_out_piso;

    PISO_reg #( .num_bits(10) ) PISO_reg_inst (
        .reset(reset), .clk(clk),
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
    wire dispout_decode, code_err_decode, disp_err_decode;

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
  

// [x] Encode 8b / 10b;    
// [X] Decoder 8b/10b 
// [X] PISO_reg
// [X] SIPO_reg

