`timescale 1 ns / 1 ps

module alt_iobuf #(
    parameter	io_standard           = "NONE",
		current_strength      = "NONE",
		current_strength_new  = "NONE",
		slew_rate             = -1,
		slow_slew_rate        = "NONE",
		location              = "NONE",
		enable_bus_hold       = "NONE",
		weak_pull_up_resistor = "NONE",
		termination           = "NONE",
		input_termination     = "NONE",
		output_termination    = "NONE",
		lpm_type              = "alt_iobuf"
) (
    input	i,
    input	oe,
    inout	io,
    output	o
);

    // Lógica de buffer de três estados (Tri-state)
    assign io = (oe == 1'b1) ? i : 1'bz;

    // Lógica de entrada
    assign o = io;

endmodule
