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
limpio=$(clear);
lista=$(ls);
listaper=$(ls -l);
listatot=$(ls -a);
total=$(ls | wc -l);
ubiact=$(pwd);

#VARIABLES DE USUARIO:
pos=0

#COLORES:
#ROJO=0;31
#AMARILLO=1;33
#AZUL=1;34
#PURPURA=0;35

#EJECUCION DEL PROGRAMA:
echo "Carpeta actual: $ubiact"
echo "Total de archivos: $total"
#echo $ubi
arbol()
{
  #VARIABLES LOCALES:
  cont=0;
  #echo "---------------> $2"

  #IMPRIMIMOS EL PUNTO DE PARTIDA
  if [ $1 -eq 0 ];then
    echo "   \e[1;33m.\e[0m "
  fi

  #IMPRIMIMOS EL LOS ARCHIVOS DE LA CARPETA ACTUAL Y SUS DERVIVADOS:
  for file in $(ls $2); do
    while [ $cont -le $1 ]; do
      printf " "
      cont=$((cont+1))
    done

    #SI EL ARCHIVO NO ES UNA CARPETA:
    if [ ! -d $file ];then
      #SI EL ARCHIVO ES EJECUTABLE:
      if [ -x $file ];then
        echo "  |__ \e[1;34m$file\e[0m"
      else
        echo "  |__ $file"
      fi
    else
      echo "  |__ \e[1;33m$file\e[0m"
    fi

    #SI EL ARCHIVO ES UNA CARPETA:
    if [ -d $file ];then
      pos=$(($1+4));
      #NOS MOVEMOS A LA DIRECCION DE LA SUBCARPETA:
      ubiact=$(pwd);
      ubiact=${ubiact}/${file}
      cd $ubiact
      arbol $pos $ubiact
      #REGRESAMOS A LA CARPETA PADRE UNA VEZ TERMINADA LA RECURSIVIDAD:
      cd ..
      ubiact=$(pwd)
    fi
    cont=0
  done

}

arbol 0 $ubiact
