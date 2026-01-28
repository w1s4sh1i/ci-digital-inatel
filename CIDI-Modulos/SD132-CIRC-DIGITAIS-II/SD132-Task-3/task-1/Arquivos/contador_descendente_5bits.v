module contador_descendente_5bits (
    input clk,
    input reset,
    output [4:0] Q
);
    reg q0, q1, q2, q3, q4;

    // Flip-flop D para cada bit
    always @(posedge clk or posedge reset) begin
        if (reset)
            q0 <= 1'b1;
        else
            q0 <= ~q0;
    end

    always @(posedge q0 or posedge reset) begin
        if (reset)
            q1 <= 1'b1;
        else
            q1 <= ~q1;
    end

    always @(posedge q1 or posedge reset) begin
        if (reset)
            q2 <= 1'b1;
        else
            q2 <= ~q2;
    end

    always @(posedge q2 or posedge reset) begin
        if (reset)
            q3 <= 1'b1;
        else
            q3 <= ~q3;
    end

    always @(posedge q3 or posedge reset) begin
        if (reset)
            q4 <= 1'b1;
        else
            q4 <= ~q4;
    end

    assign Q = {q4, q3, q2, q1, q0};
endmodule