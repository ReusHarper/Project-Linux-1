#!/bin/bash

RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"

clear	

trap "" 2 20
trap "" SIGTSTP  #anula Ctrl + C   y  Ctrl + Z

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

clear

#ENTRAMOS A LA PREBESHELL

echo -e "\t\t\t$ORANGE$BOLD**********Bienvenido a la prebeshell humano**********\n$RESET"
echo -e "Escribe la palabra \"ayuda\" para conocer las funciones\n "

contador_salida=0

while [ $contador_salida -eq 0 ];
do

	read -p "$(echo -e "$BOLD$YELLOW$USER:$BOLD$BLUE$PWD$RESET"$ "" )" comando

	case $comando in
	'arbol')
		bash arbol.sh
	;;
	'hora')
		bash hora.sh
	;;
	'fecha')
		bash fecha.sh
	;;
	'clear')
		clear
	;;
	'ayuda')
		bash ayuda.sh
	;;
	'infosis')
		bash infosis.sh
	;;
	'prebeplayer')
		bash reproductor.sh
	;;
	'volado')
		bash volado.sh
	;;
	'gato')
		bash gato.sh
	;;
	'buscar')
		bash buscar.sh
	;;
	'salir')
		exit
	;;
	*)
	command $comando
	;;
	esac

done
