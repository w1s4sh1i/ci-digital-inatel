# [x] Compile verilog/vhdl file

proc comp {filename} {
	
	if {[file exists ${filename}] == 1} {
		puts "## vcom $filename"
		vcom -93 -novopt -quiet ${filename} -work work -lint
		#vcom -2008 -novopt -quiet ${filename} -work work -lint
  } else {
	   puts "## WARNING: File not found: ${filename}"
  }
}

# [x] Create library "work" if necessary
catch {vlib work}

# Compile all sources in correct order

comp ../src/<file-name>.v
comp ../src/<file-name>_tb.v
