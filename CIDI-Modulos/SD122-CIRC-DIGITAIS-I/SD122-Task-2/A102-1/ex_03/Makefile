# Nome base dos arquivos (sem extensão)
# Regra para funcionar o Makefile
# O $dumpfile("mux_2x1_tb.vcd"); tem que ter o mesmo nome do arquivo de testbanch

MODULE = bin_to_grey
TB = bin_to_grey_tb

# Compilador e visualizador
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Arquivos de entrada e saída
SRC = $(MODULE).v
TB_SRC = $(TB).v
OUT = $(MODULE).vvp
VCD = $(TB).vcd

# compila o módulo
compila_m:
	$(IVERILOG) $(SRC)

# compila a testbanch
compila_tb:
	$(IVERILOG) $(TB_SRC)

# Compila
compila:
	$(IVERILOG) -o $(OUT) $(TB_SRC)

# Executa a simulação (gera .vcd)
vcd:
	$(VVP) $(OUT)

# GTK Wave
wave:
	$(GTKWAVE) $(VCD)