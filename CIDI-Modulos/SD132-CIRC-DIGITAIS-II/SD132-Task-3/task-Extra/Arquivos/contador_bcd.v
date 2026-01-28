module contador_bcd(
    input wire clk,
    input wire reset,
    output wire [3:0] Q1,
    output wire [3:0] Q2
);

    reg [3:0] count1;
    reg [3:0] count2;

    wire trap_condition;
    assign trap_condition = count2[0] & count1[1] & count1[0];

    always @(posedge clk or posedge reset or posedge trap_condition) begin
        if (reset || trap_condition) begin
            count1 <= 4'b0000;
        end else begin
            if (count1 == 4'b1001) begin
                count1 <= 4'b0000;
            end else begin
                count1 <= count1 + 1;
            end
        end
    end

    wire carry_out;
    assign carry_out = (count1 == 4'b1001);

    always @(posedge clk or posedge reset or posedge trap_condition) begin
        if (reset || trap_condition) begin
            count2 <= 4'b0000;
        end else if (carry_out) begin
            if (count2 == 4'b0001) begin
                count2 <= 4'b0000;
            end else begin
                count2 <= count2 + 1;
            end
        end
    end

    assign Q1 = count1;
    assign Q2 = count2;

endmodule