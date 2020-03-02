#!/bin/bash

echo "Puede buscar cualquier archivo dentro de su home utilizando el nombre de ruta /home/"
echo "En nombre de archivo usted escribirá el archivo a buscar. Ej. \"archivo.txt\""
printf "\n"
read -p "Nombre de ruta: " ruta
read -p "Nombre de su archivo: " archivo
printf "\n"

echo "Su archivo se encuentra en la siguiente dirección: " 

sudo find $ruta -name $archivo

