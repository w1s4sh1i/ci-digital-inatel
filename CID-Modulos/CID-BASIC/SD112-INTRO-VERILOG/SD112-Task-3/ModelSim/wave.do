onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /gate_not_tb/data_in
add wave -noupdate -radix binary /gate_not_tb/data_outl
add wave -noupdate -color Orange -radix binary /gate_not_tb/data_outi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 63
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 15
configure wave -childrowmargin 5
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4134 ps}
