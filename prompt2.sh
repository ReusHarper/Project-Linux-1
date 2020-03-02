#!/bin/bash


RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"


command clear	

status=0

#VALIDACION DE USUARIO

while true; do
	echo -e "\nUsuario:"
	read usuario  
	echo -e "\nContraseña:"
	read -s contramarca

	cont=`sudo grep -c "$usuario" /etc/shadow`
	con=`echo "$contrasena" | sudo -S grep -r "$usuario" /etc/shadow`
done

command clear

#ENTRAMOS A LA PREBESHELL

echo -e "\t\t\t$ORANGE$BOLD**********Bienvenido a la prebeshell humano**********\n$RESET"
echo -e "Escribe la palabra \"ayuda\" para conocer las funciones\n "



while read "$(echo -e  $BOLD$YELLOW"$USER:"$BOLD$BLUE"$PWD"$RESET"$ ")" variable 
do
	while IFS= read line; do
	 	if [ "$variable" = "$line" ];then 		
	 		
	 		./$variable.sh
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




