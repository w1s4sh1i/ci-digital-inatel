`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2023 13:49:29
// Design Name: 
// Module Name: rx_uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


 module rx_uart(
    input  logic       rx_clk,
    input  logic       rx_start,
    input  logic       rst,
    input  logic       rx,
    input  logic [3:0] length,
    input  logic       parity_type,
    input  logic       parity_en,
    input  logic       stop2,
    output logic [7:0] rx_out,
    output logic       rx_done,
    output logic       rx_error
);

    typedef enum logic [2:0] {
        IDLE             = 3'd0,
        START_BIT        = 3'd1,
        RECV_DATA        = 3'd2,
        CHECK_PARITY     = 3'd3,
        CHECK_FIRST_STOP = 3'd4,
        CHECK_SEC_STOP   = 3'd5,
        DONE             = 3'd6
    } state_type;

    state_type state, next_state;

    logic [7:0] datard;
    logic       parity_calc;
    logic [3:0] count;
    logic [3:0] bit_count;

    always_ff @(posedge rx_clk or posedge rst) begin
        if (rst) begin
            state       <= IDLE;
            count       <= 4'd0;
            bit_count   <= 4'd0;
            datard      <= 8'h00;
            rx_out      <= 8'h00;
            rx_done     <= 1'b0;
            rx_error    <= 1'b0;
            parity_calc <= 1'b0;
        end else begin
            state <= next_state;

            // LINHA ANTIGA:
            // rx_done permanecia muito dependente da lógica combinacional do estado

            // ALTERADO:
            // pulso síncrono de 1 ciclo
            rx_done <= 1'b0;

            case (state)
                IDLE: begin
                    count     <= 4'd0;
                    bit_count <= 4'd0;
                    rx_error  <= 1'b0;
                end

                START_BIT: begin
                    if (count < 4'd15)
                        count <= count + 1'b1;
                    else
                        count <= 4'd0;
                end

                RECV_DATA: begin
                    if (count == 4'd7)
                        datard <= {rx, datard[7:1]};

                    if (count < 4'd15) begin
                        count <= count + 1'b1;
                    end else begin
                        count <= 4'd0;
                        if (bit_count < (length - 1))
                            bit_count <= bit_count + 1'b1;
                        else
                            bit_count <= 4'd0;
                    end
                end

                CHECK_PARITY: begin
                    if (count == 4'd7) begin
                        if (rx != parity_calc)
                            rx_error <= 1'b1;
                    end

                    if (count < 4'd15)
                        count <= count + 1'b1;
                    else
                        count <= 4'd0;
                end

                CHECK_FIRST_STOP: begin
                    if (count == 4'd7) begin
                        if (rx != 1'b1)
                            rx_error <= 1'b1;
                    end

                    if (count < 4'd15)
                        count <= count + 1'b1;
                    else
                        count <= 4'd0;
                end

                CHECK_SEC_STOP: begin
                    if (count == 4'd7) begin
                        if (rx != 1'b1)
                            rx_error <= 1'b1;
                    end

                    if (count < 4'd15)
                        count <= count + 1'b1;
                    else
                        count <= 4'd0;
                end

                DONE: begin
                    // ALTERADO:
                    // pulso estável de conclusão
                    rx_done <= 1'b1;
                    count   <= 4'd0;
                end

                default: begin
                    count <= 4'd0;
                end
            endcase

            // ALTERADO:
            // atualização de saída no final real da recepção
            if ((state == RECV_DATA) && (count == 4'd15) && (bit_count == (length - 1))) begin
                case (length)
                    4'd5: rx_out <= {3'b000, datard[7:3]};
                    4'd6: rx_out <= {2'b00,  datard[7:2]};
                    4'd7: rx_out <= {1'b0,   datard[7:1]};
                    4'd8: rx_out <= datard[7:0];
                    default: rx_out <= 8'h00;
                endcase

                if (parity_type)
                    parity_calc <= ^datard;
                else
                    parity_calc <= ~^datard;
            end
        end
    end

    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                if (rx_start && !rx)
                    next_state = START_BIT;
            end

            START_BIT: begin
                if ((count == 4'd7) && rx)
                    next_state = IDLE;
                else if (count == 4'd15)
                    next_state = RECV_DATA;
            end

            RECV_DATA: begin
                if ((count == 4'd15) && (bit_count == (length - 1))) begin
                    if (parity_en)
                        next_state = CHECK_PARITY;
                    else
                        next_state = CHECK_FIRST_STOP;
                end
            end

            CHECK_PARITY: begin
                if (count == 4'd15)
                    next_state = CHECK_FIRST_STOP;
            end

            CHECK_FIRST_STOP: begin
                if (count == 4'd15) begin
                    if (stop2)
                        next_state = CHECK_SEC_STOP;
                    else
                        next_state = DONE;
                end
            end

            CHECK_SEC_STOP: begin
                if (count == 4'd15)
                    next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule