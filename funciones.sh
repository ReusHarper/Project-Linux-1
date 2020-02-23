#!/bin/sh
# PROYECTO 1 DE LINUX - PREBESHELL
# AUTORES:
#          Espinosa Guadarrama Arturo
#          Loran Juan Pablo
#          -- Tomas
# FECHA DE ENTREGA: 01 / marzo / 2020
#

#LIMPIAMOS LA PANTALLA:
clear

#MOSTRAMOS EL MENU:
echo "Hola mundo :D"

#COMANDOS DE USUARIO:
file="/"
limpio=$(clear);
lista=$(ls);
listaper=$(ls -l);
listatot=$(ls -a);
total=$(ls | wc -l);
ubiact=$(pwd);

#VARIABLES DE USUARIO:
pos=0;

#EJECUCION DEL PROGRAMA:
echo "Carpeta actual: $ubiact"
echo "Total de archivos: $total"
#echo $ubi
arbol()
{
  #VARIABLES LOCALES:
  cont=0; 

  #IMPRIMIMOS EL LOS ARCHIVOS DE LA CARPETA ACTUAL Y SUS DERVIVADOS:
  for file in $(ls $2); do
    while [ $cont -le $1 ]; do
      printf " "
      cont=$((cont+1))
    done
    printf "  |__ %s \n" $file
    if [ -d $file ];then
      pos=$(($1+4));
      arbol $pos ${ubiact}/${file}
    fi
    cont=0
  done

}

arbol 0


#while [ $total -ge 0 ]
#do
#  echo $total
#  total=$((total-1))
#done
