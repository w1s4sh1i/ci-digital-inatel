module contador_ascendente_4bits (
    input clk,
    input reset,
    output [3:0] Q
);
    reg q0, q1, q2, q3;

    // Flip-flop JK (J=K=1)
    always @(posedge clk or posedge reset) begin
        if (reset)
            q0 <= 1'b0;
        else
            q0 <= ~q0;
    end

    always @(posedge q0 or posedge reset) begin
        if (reset)
            q1 <= 1'b0;
        else
            q1 <= ~q1;
    end

    always @(posedge q1 or posedge reset) begin
        if (reset)
            q2 <= 1'b0;
        else
            q2 <= ~q2;
    end

    always @(posedge q2 or posedge reset) begin
        if (reset)
            q3 <= 1'b0;
        else
            q3 <= ~q3;
    end

    assign Q = {q3, q2, q1, q0};
endmodule