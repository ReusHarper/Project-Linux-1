#!/bin/bash


RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"


command clear	

status=0

#VALIDACION DE USUARIO

while [ $status = 0 ]; do

	read -p "Usuario: " usuario
	command id -u $usuario
		if [  $? = 0 ]; then
			status=1
		else 
			status=0
		fi 

done

if su -c true "$usuario"; then
  echo "Correct password"
fi

command clear

#ENTRAMOS A LA PREBESHELL

echo -e "\t\t\t$ORANGE$BOLD**********Bienvenido a la prebeshell humano**********\n$RESET"
echo -e "Escribe la palabra \"ayuda\" para conocer las funciones\n "



while read -p "$(echo -e  $BOLD$YELLOW"$USER:"$BOLD$BLUE"$PWD"$RESET"$ ")" variable 
do
	while IFS= read -r line; do
	 	if [ "$variable" = "$line" ];then 		
	 		
	 		bash $variable.sh
	 		bandera=0 

	 		break 
	 	else 
	 		bandera=1
	 		
	 	fi
	done < comandos.txt

	
	if [ $bandera = 1 ];then
 		command $variable
 		bandera=0
  	fi

done




