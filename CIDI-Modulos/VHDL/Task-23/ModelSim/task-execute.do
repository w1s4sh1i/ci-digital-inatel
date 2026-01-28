#!/bin/sh
# [x] "*.do" file created  and file *.vhd added

vlib work
vcom -2008 -work work /home/isi-se-bolsista2/BAW-Development/0-INATEL-repositorios/0-CI-DIGITAL-INATEL/ci-digital-inatel/CIDI-Modulos/VHDL/Task-23/*.vhd
vsim -onfinish stop -c work.testbench_binary2gray

# Ignore integer and internal wires 
add wave -depth 0 sim:/testbench_binary2gray/*
view wave
run 170 ns
wave zoom full
