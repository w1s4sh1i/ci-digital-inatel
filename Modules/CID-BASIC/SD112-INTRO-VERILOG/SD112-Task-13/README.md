# Atividade A-013 / SD-112

> Conteúdo descritivo e analítico

> Primitivas

:white_check_mark: Pesquisar e implemente em Verilog, utilizando primitivas built-in de transistores, o modelo de uma porta lógica AND.

:white_check_mark: Escrever um código em Verilog que implemente um MUX 2:1, utilizando primitivas built-in.

:white_check_mark: Implementar um flip-flop tipo D com reset assíncrono como uma UDP.

:white_check_mark: Definir uma testbench, simule e valide a implementação do exercício anterior.

## Executar

> Comandos para analisar / testar comportamento dos módulos:  

### GTKwave

```
$ vvp CIDI-SD112-A013-and

$ gtkwave CIDI-SD112-A013-and.vcd
```

```
$ vvp CIDI-SD112-A013-ffd

$ gtkwave CIDI-SD112-A013-ffd.vcd
```

```
$ vvp CIDI-SD112-A013-mux

$ gtkwave CIDI-SD112-A013-mux.vcd
```

### ModelSim

> 

```
$ do execute-task.do
```


## Fluxograma

![Esquemático](CID-SD112-A013-schematic.png)

## Results

![Primitivas - AND](CID-SD112-A013-1-wave.png)
![Primitivas - Flip-flop D](CID-SD112-A013-2-wave.png)
![Primitivas - Mux](CID-SD112-A013-3-wave.png)

[> Google Drive - General Report](https://docs.google.com/document/d/1XcMPJY77fL6TMtBvcFznFPcfbmsb3IuBN67DL6YdwVo)
