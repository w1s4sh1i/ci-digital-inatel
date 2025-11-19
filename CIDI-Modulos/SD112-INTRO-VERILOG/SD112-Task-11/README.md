# Atividade A-011 / SD-112

> Conteúdo descritivo e analítico

> Descrição Comportamental

:white_check_mark: Implementar de forma comportamental o circuito apresentado acima.

:white_check_mark: Pesquisar qual a funcionalidade do circuito implementado e responda: Qual o nome dado a este tipo de circuito?

- O circuito tem a funcionalidade de realizar a propagação do clock quando o valor de pulsos ser de acordo com a referência informada em CONST, com base em uma comparação de igualdade. 

-> Ação com quantidade de pulsos definida e estabilidade da saída (sem variação) com a dependência do reset (para o contador) para uma nova atuação. 

:white_check_mark: Como seria possível substituir o valor da constante por um valor configurável dinamicamente?

- Aplicar um parâmetro no header do módulo "module <module-name> #(parameter CONST = <value>)()", 'value' seria a variável de configuração dinâmica. 


## Executar

> Comandos para analisar / testar comportamento dos módulos:  

### GTKwave

```
$ vvp CIDI-SD112-A011

$ gtkwave CIDI-SD112-A011.vcd
```

### ModelSim

> 

```
$ do execute-task.do
```


## Fluxograma

![Esquemático](CID-SD112-A011-schematic.png)

## Results

![Descrição Comportamental](CID-SD112-A011-1-wave.png)

[> Google Drive - General Report](https://docs.google.com/document/d/1XcMPJY77fL6TMtBvcFznFPcfbmsb3IuBN67DL6YdwVo)
