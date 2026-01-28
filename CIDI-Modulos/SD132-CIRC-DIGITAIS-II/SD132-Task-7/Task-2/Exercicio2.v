module fsm_media (
    input clk, reset, start,
    input [7:0] data_in,
    input valid,
    output reg [7:0] media,
    output reg done
);

    // Estados codificados
    parameter IDLE   = 3'b000,
              READ_1 = 3'b001,
              READ_2 = 3'b010,
              READ_3 = 3'b011,
              READ_4 = 3'b100,
              CALC   = 3'b101,
              DONE   = 3'b110;

    reg [2:0] state, next_state;

    reg [7:0] dados [0:3];  // Memória para os 4 valores
    reg [1:0] contador;     // Para acessar posições de 0 a 3
    reg [9:0] soma;         // Para armazenar soma (até 1020 = 255*4)

    // Transição de estado
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Lógica de controle dos estados
    always @(*) begin
        case (state)
            IDLE:
                next_state = (start) ? READ_1 : IDLE;
            READ_1:
                next_state = (valid) ? READ_2 : READ_1;
            READ_2:
                next_state = (valid) ? READ_3 : READ_2;
            READ_3:
                next_state = (valid) ? READ_4 : READ_3;
            READ_4:
                next_state = (valid) ? CALC   : READ_4;
            CALC:
                next_state = DONE;
            DONE:
                next_state = IDLE;
            default:
                next_state = IDLE;
        endcase
    end

    // Lógica sequencial para armazenamento e cálculo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dados <= 4'b0000;
            soma <= 0;
            media <= 0;
            done <= 0;
            contador <= 0;
        end else begin
            case (state)
                READ_1: if (valid) dados[0] <= data_in;
                READ_2: if (valid) dados[1] <= data_in;
                READ_3: if (valid) dados[2] <= data_in;
                READ_4: if (valid) dados[3] <= data_in;
                CALC: begin
                    soma <= dados[0] + dados[1] + dados[2] + dados[3];
                    media <= soma[9:2];  // divisão por 4
                end
                DONE: done <= 1;
                IDLE: begin
                    done <= 0;
                    soma <= 0;
                end
            endcase
        end
    end

endmodule
