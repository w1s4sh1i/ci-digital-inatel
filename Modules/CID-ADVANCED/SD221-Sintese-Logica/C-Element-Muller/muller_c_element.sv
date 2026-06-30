`timescale 1 ns / 1 ps

module muller_c_element (
    input a,
    input b,
    input rst_n,
    output q
);

    logic q_next;

    always_latch begin // Asynchronous systems
        if (!rst_n) q_next <= 1'b0;
        else begin
		case ({a, b})
		    2'b00 : q_next = 1'b0;
		    2'b11 : q_next = 1'b1;
		    default: q_next = q;
		endcase 
    	
    	end
    end
    assign q = q_next;
		
endmodule

