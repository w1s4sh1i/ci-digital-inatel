# CI Digital - PicoRV32

> Description - june, 9 2026

## FILE TREE 


## EXECUTE

> Icarus
```
$ iverilog -Wall -o fpga-rv32 fpga_rv32.v
$ gtkwave --rcvar 'fill_waveform 1' ./Icarus/*.vcd ./Icarus/*.gtkw
```

> ModelSim

```
$ 
```

## MODULES

Modularizar o PicoRV32 é um excelente exercício de arquitetura de computadores. Por padrão, o PicoRV32 foi intencionalmente projetado de forma monolítica (quase todo o processador dentro de um único módulo principal) para facilitar a **otimização de área e timing** feita pelas ferramentas de síntese.

Para separá-lo em sub-blocos funcionais (arquivos distintos), precisamos mapear as grandes estruturas internas e transformá-las em módulos independentes conectados por um módulo principal (Top Level).

Estratégia de Modularização Sugerida
Podemos dividir o PicoRV32 em 4 blocos principais:

Unidade de Controle e Decodificação (**picorv32_control.v**)

O que extrair: A máquina de estados (cpu_state), o registrador de instrução (ir), o Program Counter (reg_pc) e toda a lógica combinacional que gera os sinais de controle para o restante do circuito.

Banco de Registradores (**picorv32_regfile.v**)

O que extrair: O array cpuregs (os 32 registradores de uso geral do RISC-V), junto com sua lógica de leitura (portas de leitura para rs1 e rs2) e a lógica de escrita síncrona.

Unidade Lógica e Aritmética - ULA (**picorv32_alu.v**)

O que extrair: O bloco que realiza as operações matemáticas e lógicas (somas, subtrações, comparações ordinais, AND, OR, XOR) e os deslocadores (shifters).

Interface de Memória e Alinhamento (**picorv32_mem_if.v**)

O que extrair: A lógica que controla os sinais externos mem_valid, mem_instr, mem_wstrb, mem_addr e faz o alinhamento de bytes/halfwords para instruções de carga (lw, lh, lb) e armazenamento (sw, sh, sb).

Passo a Passo para a Implementação
Criação dos Arquivos Independentes:
Cada bloco listado acima se tornará um module com suas próprias entradas e saídas (input e output). Todo sinal interno que antes era lido por outro bloco agora deve virar uma porta física do submódulo.

Criação do Módulo Top (**picorv32_top.v**):
O arquivo original picorv32.v passará a conter apenas a declaração das portas externas do processador, a declaração de fios internos (wire) para interconectar os blocos, e a instanciação dos submódulos criados.

## REPORT

> [Relatório (jun, 9 2026): EXERCÍCIOS PRÁTICOS - System-on-Chip Codes](https://docs.google.com/document/d/1SC5mzlqpmt6POQ_S6cJVcvW-Xd2FG7H7dbG6CwOQvek)

## REFERENCES

1. []();

2. []();

3. []();

