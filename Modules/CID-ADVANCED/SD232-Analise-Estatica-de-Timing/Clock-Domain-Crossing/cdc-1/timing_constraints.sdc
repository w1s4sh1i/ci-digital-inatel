# set_units -capacitance 1fF
# set_units -time 1ps
# create_clock -name "clk" -period 180.0 -waveform {0.0 90.0} [get_ports clk]
# set_clock_gating_check -setup 0.0


reg [WIDTH-1:0] ff_src;

    (* ASYNC_REG = "TRUE" *) reg [WIDTH-1:0] ff_sync_chain1;
    (* ASYNC_REG = "TRUE" *) reg [WIDTH-1:0] ff_sync_chain2;
    
# Defina o atraso máximo para o período do clock de destino (ex: 10.0 ns)
set_max_delay -datapath_only -from [get_cells -hierarchical -filter {NAME =~ *ff_src_reg*}] -to [get_cells -hierarchical -filter {NAME =~ *ff_sync_chain1_reg*}] 10.0

# Alternativa B
# set_clock_groups -asynchronous -group [get_clocks src_clk] -group [get_clocks dest_clk]
