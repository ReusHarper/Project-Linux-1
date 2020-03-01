<<<<<<< HEAD
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

  #printf " -----------------> $ubiact\n"
  #IMPRIMIMOS EL LOS ARCHIVOS DE LA CARPETA ACTUAL Y SUS DERVIVADOS:
  for archivo in "$ubiact"/*; do
    while [ $cont -le $1 ]; do
      if [ $cont -eq 0 ]; then
        printf "   |"
      fi
      printf " "
      cont=$((cont+1))
    done

    #SI EL ARCHIVO ESTA EN UNA SUBCARPETA:
    if [ $3 -eq 1 ]; then
      printf "|"
    fi

    #SI EL ARCHIVO ES UNA CARPETA:
    if [ -d "${archivo}" ]; then
      printf "__ \e[1;33m${archivo##*/}\e[0m \n"
      pos=$(($1+4));
      ubiact=${ubiact}/${archivo##*/}
      cd "$ubiact"
      arbol $pos "$ubiact" 1
      cd ..
      ubiact=$(pwd)

    #SI EL ARCHIVO ES EJECUTABLE:
    elif [ -x "$archivo" ];then
        printf "__ \e[1;34m${archivo##*/}\e[0m \n"

    #SI ES UN ARCHIVO COMUN:
    elif [ -f "$archivo" ]; then
        printf "__ ${archivo##*/} \n"

    #SI NO CUENTA CON ARCHIVOS:
    else
      printf "    (Vacio)\n"

    fi

    cont=0
  done

}

arbol 0 "$ubiact" 0
