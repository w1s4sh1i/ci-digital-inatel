# ModelSim base file
# Alterar referências para execução
# Definir bashscript para gerar o .do

vlib work

vlog -work work *.v

# vsim -onfinish stop -c work.<module-filename>_tb
vsim -onfinish stop -c work.gate_not_tb

# Ignore integer and internal wires 
# add wave -depth 0 sim:/<module-filename>_tb/*

add wave -depth 0 sim:/gate_not_tb/*

view wave

run -all

wave zoom full 
