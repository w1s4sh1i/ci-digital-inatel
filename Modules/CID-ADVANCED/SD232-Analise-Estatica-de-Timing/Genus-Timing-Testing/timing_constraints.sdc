set_units -capacitance 1fF
set_units -time 1ps
create_clock -name "clk" -period 5000.0 -waveform {0.0 2500.0} [get_ports clk]
set_clock_gating_check -setup 0.0
