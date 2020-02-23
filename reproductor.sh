#!/bin/sh
#

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
      ubiact=$(pwd);
      ubiact=${ubiact}/${file}
      cd $ubiact
      arbol $pos $ubiact
      cd ..
      ubiact=$(pwd)
    fi
    cont=0
  done

}



menuRep()
{

  #VARIABLES LOCALES:
  opcion=0;


  while [ $opcion -ne 6 ]; do
    clear
    printf "\n\t>>>>>>>>>>>>>>>>> REPRODUCTOR PREBESHELL - Version 1.0.0 <<<<<<<<<<<<<<<<<\n\n"
    printf " Tu ubicacion actual es: \e[1;33m$ubiact\e[0m \n\n"
    printf " Menu del reproductor prebeshell:\n\n"
    printf "\t 1.- Reproducir la lista de la carpeta actual\n"
    printf "\t 2.- Cambiar de carpeta\n"
    printf "\t 3.- Subir una carpeta\n"
    printf "\t 4.- Listar los archivos y subcarpetas de la carpeta actual\n"
    printf "\t 5.- Listar opciones del reproductor prebeshell\n"
    printf "\t 6.- Salir del reproductor prebeshell\n\n"
    printf " Seleccione una opcion: "
    read opcion

    if [ $opcion -le 0 -o $opcion -ge 7 ]; then
      printf "\n Dato invalido, presione cualquier tecla para continuar ... "
      read opcion
      opcion=0;

    else

      #LIMPIAMOS LA PANTALLA:
      clear

      #INGRESAMOS A UNA DE LAS OPCIONES ESCOGIDAS POR EL USUARIO:
      if [ $opcion -eq 1 ]; then
        printf "\n\t>>>>>>>>>>>>>> REPRODUCCION DE LA LISTA ACTUAL <<<<<<<<<<<<<<\n\n"
      fi
      if [ $opcion -eq 2 ]; then
        printf "\n\t>>>>>>>>>>>>>> CAMBIAR DE CARPETA ACTUAL <<<<<<<<<<<<<<\n\n"
        printf " Ingrese el nombre o la ruta absoluta de la carpeta destino: "
        read nombre

        if [ -d $nombre ]; then
          ubiact=${ubiact}/${nombre}
          cd $ubiact
        else
          printf "\n El nombre o la direccion de la carpeta destino no existe, intente mas tarde."
          printf "\n Ingrese cualquier tecla para continuar ... "
          read opcion
          opcion=0;
        fi

      fi
      if [ $opcion -eq 3 ]; then
        printf "\n\t>>>>>>>>>>>>>> SUBIR CARPETA <<<<<<<<<<<<<<\n\n"
        printf " Ingrese la ruta absoluta de la carpeta que desee agregar a la carpeta actual: "
        read nombre

        if [ -d $nombre ]; then
          mv $nombre $ubiact
        else
          printf "\n El nombre o la direccion de la carpeta destino no existe, intente mas tarde."
          printf "\n Ingrese cualquier tecla para continuar ... "
          read opcion
          opcion=0;
        fi
      fi
      if [ $opcion -eq 4 ]; then
        printf "\n\t>>>>>>>>>>>>>> LISTA DE ARCHIVOS Y SUBCARPETAS <<<<<<<<<<<<<<\n\n"
        printf " Opciones de listado:\n\n"
        printf "\t1.- Listado en forma tradicional\n"
        printf "\t2.- Listado en forma de arbol\n\n"
        printf "\t    Seleccione una opcion de listado: "
        read opcion
        if [ $opcion -eq 1 ]; then
          printf "\n\t"
          ls
        else
          if [ $opcion -eq 2 ]; then
            arbol 0 $ubiact
          else
            printf "\n\n Dato invalido, intente mas tarde ... "
          fi
        fi
        printf "\n\n Presione cualquier tecla para continuar ... "
        read opcion
        opcion=0;
      fi
      if [ $opcion -eq 5 ]; then
        printf "\n\t>>>>>>>>>>>>>> LISTA DE OPCIONES DEL REPRODUCTOR PREBESHELL <<<<<<<<<<<<<<\n\n"
        printf " [k] > Pausar\n"
        printf " [l] > Siguiente\n"
        printf " [j] > Previa\n"
        printf " [s] > Repetir\n"
        printf " [d] > Adelante\n"
        printf " [a] > Atras\n"
        printf " [e] > Subir volumen\n"
        printf " [w] > Bajar volumen\n"
        printf " [q] > Quitar reproduccion\n\n"
        printf " Presione cualquier tecla para continuar ... "
        read opcion
        opcion=0;
      fi

    fi

  done

  #LIMPIAMOS LA PANTALLA:
  clear

}

#reproductor(){}

menuRep
#reproductor
