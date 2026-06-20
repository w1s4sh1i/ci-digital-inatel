# AXI4-Lite System (subordinate, master)

> To implement and simulate a system composed of an AXI4-Lite master connected to an AXI4-Lite subordinate peripheral. The system should allow the master module to write values ​​to the control registers, read the control and status registers, validate the responses from channels B and R, and verify correct communication through simulation.

## File tree

> 1 directory, 5 images, 7 files

```
.
├── README.md
├── axi4_lite_system.vcd
├── axi4-system
├── axi4-lite.gtkw
├── axi4-lite-system-0-terminal.png
├── axi4-lite-system-1-testbench.png
├── axi4-lite-system-2-dut-system.png
├── axi4-lite-system-3-1-uut-master.png
├── axi4-lite-system-3-2-uut-master.png
├── axi4-lite-system-4-uut-subordinate.png
├── axi4_lite_master.v
├── axi4_lite_subordinate.v
├── axi4_lite_system_top.v
└── axi4_lite_system_tb.v
```

## Terminal: Icarus + Gtkwave

```
$ iverilog -Wall -o axi4-lite-system *.v
$ vpp axi4-lite-system
$ gtkwave *.vcd *.gtkw
```

## REPORT 

[EXERCÍCIOS PRÁTICOS - INTEGRAÇÃO AXI4-LITE MASTER COM PERIFÉRICO AXI4-LITE SUBORDINATE - Google Docs](https://docs.google.com/document/d/1a9-9l7l_EiEfLKbRdGpxhbf5CVcbH_8yrNffXsctPtM/edit?usp=sharing)
