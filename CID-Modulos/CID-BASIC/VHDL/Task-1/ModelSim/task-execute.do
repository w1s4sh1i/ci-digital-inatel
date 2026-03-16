#!/bin/sh
# [x] "*.do" file created  and file *.vhd added

vlib work
vcom -2008 -work work /home/isi-se-bolsista2/BAW-Development/0-INATEL-repositorios/0-CI-DIGITAL-INATEL/ci-digital-inatel/CIDI-Modulos/VHDL/Task-1/*.vhd
vsim -onfinish stop -c work.testbench_mux_2x1

# Ignore integer and internal wires 
add wave -depth 0 sim:/testbench_mux_2x1/*
view wave
run -all
wave zoom full
