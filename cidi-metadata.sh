# -> Makefile 
# CID DIGITAL STUDENT INFOR

# [ ] Get date in system; 

# [ ] Dynamic Generate 
# for item in "${ListArray[@]}"; do
#    declare -A $item
# done

declare -A PROGRAM=(
					["NAME"]="CI Digital" 
					["VERSION"]="T2/2025"
)
declare -A INSTITUTE=(
					["ACRONYM"]="INATEL" 
					["NAME"]="Instituto Nacional de Telecomunicação" 
)
declare -A LOCAL=(
					["CITY"]="Santa Rita do Sapucaí" 
					["UF"]="MG"
)


# ID is a build key 
# Rever sobre reutizar formatação com ID e module.
declare -A MODULE=(
					["SD100"]="Introdução a Microeletrônica"
					["SD112"]="Introdução a Verilog"
					["SD122"]="Circuito Digitais I"
					["SD132"]="Circuito Digitais II"
					["SD142"]="Circuito Digitais III"
					["SD192"]="Projeto Orientado I"
					#[" "]=" "
)

# declare -A MODULE=(
#					["ID"]="CLASS_ID"
#					["NAME"]="CLASS_NAME"
# )

declare -a ADVISOR=(
					["Basic"] = "Felipe Rocha"	
					["Advanced"] = "Elivander Pereira"				
)

declare -a CONTACT=(
					["Basic"] = "felipef.rocha@inatel.br"
					["Advanced"] = "elivander.pereira@inatel.br"
)

# declare -A ADVISOR
# ADVISOR["NAME"]="NAMES"   
# ADVISOR["CONTACT"]="CONTACTS"

declare -A DEVELOPER=(
						["NAME"]="André Bezerra" 
						["CONTACT"]="andrefrbezerra@gmail.com"
)

declare -a TYPE=(
					"Laboratory"
					"Testbench" 
					"Project"
)

CURRENT_DATE=$(date +"%B, %d %Y")


