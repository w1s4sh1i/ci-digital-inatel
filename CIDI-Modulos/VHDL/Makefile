# Folder Path 
#mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
#current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# send fold for execute script

# ghdl:
GHDL_CMD 	= ghdl
GHDL_FLAGS 	= -fsynopsys --std=08

# entity-task:
# Define the parallel lists of keys and values
KEYS  	:= 1 23 4 5 6 7 8 9

VALUES	:= mux_2x1 binary2gray var_vs_signal vhdl_types single_port_memory dual_port_memory real_time_clock read_stimulus

# S_TIME := 

# Function to retrieve a value by its key
# $(1) := key to look up
# $(2) := list of KEYS
# $(3) := list of VALUES
lookup	= $(word $(shell echo $(2) | tr ' ' '\n' | grep -n $(1) | cut -d: -f1), $(3))

# parameters:
CLASS	= "put the class id here"
S_TIME	= 150ns

ENTITY 	:= $(call lookup,$(CLASS), $(KEYS), $(VALUES))

TASK_DIR	= "Task-$(CLASS)"
I 			= "C$(CLASS)_design.vhd"
T 			= "C$(CLASS)_testbench.vhd"
E 			= "testbench_$(ENTITY)"

WAVES_DIR 	= waves

compile:
	# @cd $(ROOT_DIR)/$(TASK_DIR)
	@mkdir -p $(TASK_DIR)/$(WAVES_DIR)
	$(GHDL_CMD) -a $(GHDL_FLAGS) $(TASK_DIR)/$(I) $(TASK_DIR)/$(T) 
	$(GHDL_CMD) -e $(GHDL_FLAGS) $(E)
	# task < 9, 9 não tem sinais
	$(GHDL_CMD) -r $(GHDL_FLAGS) $(E) --vcd=$(TASK_DIR)/$(WAVES_DIR)/$(E).vcd --wave=$(TASK_DIR)/$(WAVES_DIR)/$(E).ghw --stop-time=$(S_TIME)
	@gtkwave $(TASK_DIR)/$(WAVES_DIR)/$(E).ghw & 
	@rm *.cf
