# Atividades do Módulo VHDL

> VHSIC Hardware Description Language - ;


|TID   		|TASK               |LEVEL		 | :white_check_mark:	|
|:----: 	|:----              |:----		 | :----:               |
|E-101		|[ ](/Task-1)		|BASIC		 | :white_check_mark:	|
|E-102		|[ ](/Task-2)		|BASIC		 | :white_check_mark:	|
|E-103		|[ ](/Task-3)		|BASIC		 | :white_check_mark:	|
|E-104		|[ ](/Task-4)		|BASIC		 | :white_check_mark:	|
|E-105		|[ ](/Task-5)		|BASIC		 | :white_check_mark:	|
|E-106		|[ ](/Task-6)		|BASIC		 | :white_check_mark:	|
|E-107		|[ ](/Task-7)		|BASIC		 | :white_check_mark:	|
|E-108		|[ ](/Task-8)		|BASIC		 | :white_check_mark:	|
|E-109		|[ ](/Task-9)		|BASIC		 | :white_check_mark:	|

## Execute

```
$ ghdl -a -fsynopsys --std=08 *.vhd

$ ghdl -e -fsynopsys --std=08 <testbench_entity>

$ ghdl -r -fsynopsys --std=08 *_testbench --ghw=waveform.ghw

$ gtkwave waveform.ghw

```

ou pode exercutar o Makefile desta pasta com as informações de cada task:

```

$ make CLASS=<task-number> S_TIME=<value and SI> ... 

```

## Anotações 

> Funções das implementações: 

1. - ;

![](/Task-1/CID-VHDL-E101-wave.png);

23. - ;

![](/Task-23/CID-VHDL-E1023-wave.png);

4. - ;

![](/Task-4/CID-VHDL-E104-wave.png);

5. - ;

![](/Task-5/CID-VHDL-E105-wave.png);

6. - ;

![](/Task-6/CID-VHDL-E106-wave.png);

7. - ;

![](/Task-7/CID-VHDL-E107-wave.png);

8. - ;

![](/Task-8/CID-VHDL-E108-wave.png);

9. - ;

![](/Task-9/CID-VHDL-E109-wave.png);

## Referências

1. [IEEE Standard VHDL Language Reference Manual, Std 1076-2008, IEEE, 2009]();

2. [Ashenden, P. J. (2008). The Designer's Guide to VHDL (3rd ed.). Morgan Kaufmann.]();

3. [Pedroni, V. A. (2020). Circuit Design with VHDL (3rd ed.). MIT Press.]();

4. [Chu, Pong P. FPGA Prototyping by VHDL Examples: Xilinx Spartan-3 Version. Wiley-Interscience, 2008]();

[> Google Drive - General Report](https://docs.google.com/document/d/1tS1Sp0zDvDQFFnIN9WWTCYqzwZ0vjvvPekUBJOgbVFo/edit?usp=sharing)
