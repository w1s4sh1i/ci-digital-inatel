#!/bin/bash

MODULE = "gate_not"
# create suppot files

command = "{$MODULE}.v {$MODULE}_tb.v task-execute.do" 

touch $command

: <<'COMMENT_BLOCK'

# Add header information - module and testbench
# foreach file 
*.v 

# internal text task-execute
# cat > task-execute.do << EOF
#
# EOF
echo "vlib work" | tee task-execute

echo "vlog -work work *.v" | tee task-execute

echo "vsim -onfinish stop -c work.{$MODULE}_tb" | tee task-execute

echo "add wave -depth 0 sim:/{$MODULE}_tb/*" | tee task-execute

echo "view wave" | tee task-execute

echo "run -all" | tee task-execute

echo "wave zoom full" | tee task-execute

COMMENT_BLOCK
