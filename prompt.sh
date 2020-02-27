#!/bin/bash


RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"


command clear	

status=0

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

echo "\t\t\t$ORANGE$BOLD**********Bienvenido a la prebeshell humano**********\n$RESET"
echo "Escribe la palabra \"ayuda\" para conocer las funciones\n "

#A="ayuda"

while read -p "$(echo  $BOLD$YELLOW"$USER:"$BOLD$BLUE"$PWD"$RESET"$ ")" variable 
do
 	if [ "$variable" = "ayuda" ];then 		
 		sh ayuda.sh
 	else 
    	command $variable		
    fi

done

