set_property SRC_FILE_INFO {cfile:/home/bezerra-andre/0-INATEL-Development/BAW/ci-digital-inatel/Modules/CID-ADVANCED/SD232-Analise-Estatica-de-Timing/Clock-Domain-Crossing/cdc-1/timing_constraints.sdc rfile:../../../../timing_constraints.sdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_units -capacitance 1fF
set_property src_info {type:XDC file:1 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_units -time 1ps
set_property src_info {type:XDC file:1 line:3 export:INPUT save:INPUT read:READ} [current_design]
create_clock -name "clk" -period 180.0 -waveform {0.0 90.0} [get_ports clk]
set_property src_info {type:XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
set_clock_gating_check -setup 0.0
