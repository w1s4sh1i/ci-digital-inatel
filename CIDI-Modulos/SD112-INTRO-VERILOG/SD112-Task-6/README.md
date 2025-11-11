# Atividade A-006 / SD-112

> Conteúdo descritivo e analítico

> Declarações Processuais e Contínuas

:white_check_mark: Implementar e simular um codificador binário que atenda aos seguintes requisitos: 
- I. possui uma entrada de 4 bits codificada em binário que representará valores de 0x0 a 0xF, 
- II. possui uma entrada de 1 bit para o segmento DP, 
- III. possui uma saída de 8 bits que deve ser organizada da forma out[7:0] = [DP,A,B,C,D,E,F,G]. Os valores codificados no display serão apenas os valores com representação hexadecimal (números 0... 9, letras A... F). Qualquer outro valor deve mostrar o display inteiramente apagado.


:white_check_mark: Implemente um bloco que conte de 0x0 a 0xF para alimentar o bloco do exercício anterior. Sempre que a contagem atingir o valor 0xF, o sinal para o segmento DP deve ser invertido (de 0 para 1, ou de 1 para 0). 


## Executar

> Comandos para analisar / testar comportamento dos módulos: 

### GTKwave

```
$ vvp CIDI-SD112-A006

$ gtkwave CIDI-SD112-A006.vcd
```

### ModelSim

> 

```
$ do execute-task.do
```


## Fluxograma

![Esquemático](CID-SD112-A006-schematic.png)

## Results

![Processuais e Contínuas](CID-SD112-A006-wave.png)

[> Google Drive - General Report](https://docs.google.com/document/d/1XcMPJY77fL6TMtBvcFznFPcfbmsb3IuBN67DL6YdwVo)
