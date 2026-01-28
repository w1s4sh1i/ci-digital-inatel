# Module: mux_2x1

# ModelSim Makefile base

# [x] ModelSim command 
# $ make MODULE_FILE=mux_2x1 && cd ModelSim && modelsim -do task-execute.do

# [x] Root path para leitura dos arquivos e definição do projeto
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

VERSION		= 2008
DO_FILE	 	= task-execute
MODULE_FILE = "put the entity here"

define TASK_EXECUTE
#!/bin/sh
# [x] "*.do" file created  and file *.vhd added

vlib work
vcom -$(VERSION) -work work $(ROOT_DIR)/*.vhd
vsim -onfinish stop -c work.testbench_$(MODULE_FILE)

# Ignore integer and internal wires 
add wave -depth 0 sim:/testbench_$(MODULE_FILE)/*
view wave
run 150 ns
wave zoom full
endef

export TASK_EXECUTE

create-file:
	@touch ModelSim/$(DO_FILE).do
	@echo "$$TASK_EXECUTE" > ModelSim/$(DO_FILE).do
