# Máquinas de Estado - Moore and Mealy

> Atividade A-206 / SD-132

:white_check_mark: Um sistema que deve detectar a sequência de bits “101” e gerar saída 1 quando ela aparecer:

> Justifique quantos estados seriam necessários em uma implementação:

1. Moore (4); 

2. Mealy (3); 

:white_check_mark: Indique qual modelo seria mais eficiente para esse caso e o motivo.

- O Mealy a melhor eficiência para sistema com elevado *throughput* (altas frquências - sistemas críticos).

## Executar

> Comandos para analisar / testar comportamento dos módulos:

### GTKwave

```
$ vvp CIDI-SD132-A206

$ gtkwave CIDI-SD132-A206.vcd
```

### ModelSim

> 

```
$ do execute-task.do
```


## Fluxograma

![Esquemático](CID-SD132-A206-schematic.png)

## Results

![](CID-SD132-A206-1-wave.png)
![](CID-SD132-A206-2-wave.png)

[> Google Drive - General Report](https://docs.google.com/document/d/1ONek1qarL9ffCkK64y7RGFRO1fsGOx6Uon5N0k2VMTU/)
