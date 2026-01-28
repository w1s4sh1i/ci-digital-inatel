#!/bin/bash

# Local support file
# [x] Task build terminal information;
# [ ] Take id folder;
# [ ] Variaveis locais para a geração da atividade;
# [ ] Create :
# FOLDERS: "SDXXX-Task-{i}" 
# + Files: README.md (template-0), <task>.v (template-1) and <task>_tb.v (template-2) 
# EACH FOLDER -> SUB-SUB-FOLDERS: Icarus and ModelSim, task-{i}

TASK="$1"
ACTION="$2"
MODULE_ID="$3"

VARIABLES_IMPORT="/home/isi-se-bolsista2/BAW-Development/0-INATEL-repositorios/0-CI-DIGITAL-INATEL/ci-digital-inatel/cidi-metadata.sh"

# template-0

# template-1

# template-2

# Get ID folder like key
source $VARIABLES_IMPORT

# File infor base 
echo "/*
Program: ${PROGRAM["NAME"]} ${PROGRAM["VERSION"]}
Class: ${MODULE[$MODULE_ID]}
Class-ID: $MODULE_ID
Advisor: ${ADVISOR[0]} 
Advisor-Contact: ${CONTACT[0]}
Institute: ${INSTITUTE["ACRONYM"]} - ${LOCAL["CITY"]} / ${LOCAL["UF"]}  
Development: ${DEVELOPER["NAME"]}
Student-Contact: ${DEVELOPER["CONTACT"]}
Task-ID: A$TASK
Type: ${TYPE[$ACTION]}
Data: $CURRENT_DATE
*/
"

# Define folder 

# mkdir -p "$MODULE_ID-Task-$i" x -> 1 .. 12

# Definir número de atividades

# Create .v 
# Adicionar template 

# Create _tb.v 
# Adicionar template 




