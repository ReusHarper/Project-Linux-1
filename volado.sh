#!/bin/bash

declare -a arr
desicion="Si"
arr=(cara cruz)


RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
BLUE="\033[0;34m"
ORANGE="\033[0;33m"
RED="\033[1;31m"

command clear
echo -e "\t$BOLD$RED BIENVENIDO AL JUEGO DEL VOLADO $RESET"

while [ "$desicion" = "Si" ]; do

echo -e "$BOLD Elija entre cara o cruz $RESET"
read -p "Ingrese su elección: " eleccion

aleatorio=$(( $RANDOM % 2 ))


echo -e "$BOLD"
echo -e " ______"
echo -e "/  /|   \ "
echo -e "|   |    |"
echo -e "|   |    |"
echo -e "\ ____  /"
echo -e "$RESET"


echo "Se esta lanzando la moneda ..."

sleep 3s

res_aleatorio=${arr[$aleatorio]}
echo "El resultado del volado fue: $res_aleatorio"
printf "\n"

if [ "$eleccion" = "$res_aleatorio" ]; then
	echo -e "$BOLD$YELLOW*****************"
	echo -e "*Usted ha ganado*"
	echo -e "*****************$RESET"

else
	echo -e "$BOLD$BLUE------------------"
	echo -e "|Usted ha perdido|"
	echo -e "------------------$RESET"

fi

read -p "¿Desea jugar de nuevo? [Si/No]: " desicion

done
