# Atividade A-007 / SD-112

> Conteúdo descritivo e analítico

>  Circuito simples de debounce

:white_check_mark: Compilar o código fonte e a testbench fornecida e execute a simulação do circuito de debounce.

:white_check_mark: Analisar o circuito apresentado e explique o funcionamento do código debounce fornecido. 

- Tem a função de eliminar o efeito de repique (bouncing), que são múltiplas oscilações elétricas indesejadas causadas por interruptores / botões.

:white_check_mark:  Quais tipos de declaração são utilizados no código (contínua ou processual)? Aponte os estilos utilizados em cada parte do código. 

- 

:white_check_mark: Qual estilo de implementação (RTL, comportamental ou estrutural) visto no código?

- Comportamental

:white_check_mark: Após simular o código, descreva o comportamento observado na simulação. 

- Comportamento descrito na imagem de suporte.

:white_check_mark: Como o valor de clean_out varia ao longo do tempo quando o botão é pressionado e solto? 

- Alterna de forma a compensar a oscilação indesejada. 

:white_check_mark: O filtro de debounce apresenta algum atraso? Qual o impacto desse atraso no sistema?

- Tem impacto no processo de sincronização operacional do sistema. 

:white_check_mark: Qual o valor do atraso observado e como controlar esse atraso? Altere o código de forma a simular um atraso de 64 pulsos de clock.

- Valor experimental (tabela de testes) e implementação para os 64 pulsos nas imagens.

## Executar

> Comandos para analisar / testar comportamento dos módulos: 

### GTKwave

```
$ vvp CIDI-SD112-A007

$ gtkwave CIDI-SD112-A007.vcd
```

### ModelSim

> 

```
$ do execute-task.do
```


## Fluxograma

![Esquemático](CID-SD112-A007-schematic.png)

## Results

![Circuito simples de debounce](CID-SD112-A007-1-wave.png)
![Debounce - 64 pulsos](CID-SD112-A007-2-wave.png)
![Debounce - 32 pulsos](CID-SD112-A007-3-wave.png)
![Debounce - 128 pulsos](CID-SD112-A007-4-wave.png)
![Debounce - 16 pulsos](CID-SD112-A007-5-wave.png)

[> Google Drive - General Report](https://docs.google.com/document/d/1XcMPJY77fL6TMtBvcFznFPcfbmsb3IuBN67DL6YdwVo)
