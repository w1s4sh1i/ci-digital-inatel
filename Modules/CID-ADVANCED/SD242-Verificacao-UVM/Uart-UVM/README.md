# CI DIGITAL INATEL: SD242 - VERICAÇÃO (UVM)

> Descrição

## VIVADO + UVM (Windows e GNU-LINUX)

> Descrição dos passo para rodas e analisar as waves

### Tutorial de instalação

> arquivo externo de orientação e links para configuração do ambiente de desenvolvimento (Windows ou GNU-linux).

### Arquivos de referência

Ao acessar a pasta específica do estudante, realizar a cópia dos arquivos de referência disponibilizados pelo ORIENTADO do módulo SD242 em:

- Código de exemplo (UART):

> [Google Drive](https://drive.google.com/drive/folders/1FMSsFDzbMlL4jxrEqW6BnQj5F5GUkHS3?usp=drive_link);

> [Github]();


### Execução dos arquivos

> descrição dos passo-a-passos:

#### I - laboratório INATEL

> Realizar acesso aos servidores pelo IP com USER e PASSOWORD ; (Lista de servidores disponíveis, usuário e password na documentação de acesso interno do laboratório - apenas para os estudantes participantes da residência) 

> Acesso do servidor pelo :

```
$ IP 
```

> Ao conectar, inserir o USER:

```
$ USER
```
>

```
$ PASSWORD
```

> Acessar as pastas com documentação das turmas (ID): 1, 2 ... : 

```
$ ls && cd turma-ID // >>> Validar no laboratório
```

> Acessar a pasta referente ao Estudante da turma, definida no passo anterior: 

```
$ cd STUDENT
```

#### II - Computador Pessoal

> Inicializar o VIVADO ClI / NO GUI no (sem a versão gráfica > WINDOWS via powershell : bash) para realização dos testes - pasta principal de desenvolvimento: 

> cmd.exe /c "C:\Xilinx\Vivado\<versão>\settings64.bat"

```
$ vivado -mode tcl
```
> Na GUI do VIVADO executar os comandos para geração das waves.
```
$ set -SCRIPT_TARGET "all" 
$ set -GUI_MODE "gui"
```

### Executar os códigos

```
$ source run.tcl
```

> 

### Visualizar waves (ondas)

> Alternativa para visualização da onda 

```
$ 
```


## Icarus + Verilator (GNU-LINUX)

> Descrição

### Tutorial de instalação

> arquivo externo de orientação e links para configuração do ambiente de desenvolvimento (Windows ou GNU-linux).

### Execução dos arquivos

>

### Visualizar waves (ondas)

> Utilização do Verilator 


```
$ 
```

## Atividade Realizada pela Turma T2/25

> Arquivo de descrição 1

> Arquivo de descrição 2

## Referência 

