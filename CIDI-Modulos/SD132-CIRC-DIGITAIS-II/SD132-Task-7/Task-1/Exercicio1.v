module fsm_moore_0110 (
    input clk,
    input reset,
    input in,
    output reg out
);

    // Codificação dos estados com parâmetros (Verilog puro)
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] state, next_state;

    // Transição de estado (síncrona com reset)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Lógica do próximo estado (com sobreposição)
    always @(*) begin
        case (state)
            S0: begin
                case (in)
                    1'b0: next_state = S1;
                    1'b1: next_state = S0;
                endcase
            end
            S1: begin
                case (in)
                    1'b0: next_state = S1;
                    1'b1: next_state = S2;
                endcase
            end
            S2: begin
                case (in)
                    1'b0: next_state = S1;
                    1'b1: next_state = S3;
                endcase
            end
            S3: begin
                case (in)
                    1'b0: next_state = S4;
                    1'b1: next_state = S0;
                endcase
            end
            S4: begin
                case (in)
                    1'b0: next_state = S1;
                    1'b1: next_state = S2;
                endcase
            end
            default: next_state = S0;
        endcase
    end

    // Saída depende apenas do estado (Moore)
    always @(*) begin
        case (state)
            S4: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
