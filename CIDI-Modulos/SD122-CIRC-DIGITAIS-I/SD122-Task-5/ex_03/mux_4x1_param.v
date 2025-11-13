module mux_4x1_param #(parameter N = 4)(
    input       [N-1:0] in0,in1,in2,in3,
    input       [1:0]   sel,
    output reg  [N-1:0] out
);

    always @(*)begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;

            default: out = 1'bx; 
        endcase
        
    end
    
endmodule