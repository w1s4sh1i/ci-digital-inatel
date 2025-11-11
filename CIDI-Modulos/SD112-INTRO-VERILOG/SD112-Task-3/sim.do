# [x] Define reload command to recompile everything and rerun the simulation

proc reload {} {
  do comp.do
  do sim.do
}

# [x] Define top entity of the design
set top workbench

# [x] Load design into simulation
echo "Sim: load design"
vsim -novopt -wlfdeleteonquit work.${top}

# [x] Load wave file configuration
echo "Sim: load wave-file(s)"
catch {do wave.do}

# [x] Set all signals to be logged
echo "Sim: log signals"
log -r /*

# [x] Run simulation
echo "Sim: run ..."
run 1200 ns

# [x] Restore wave file.
# - This can be used to restore cursor and view position
catch {do wave-restore.do}
