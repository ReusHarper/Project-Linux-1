#!/bin/sh
# -*- ENCODING: UTF-8 -*-

#COMANDOS DE USUARIO:
limpio=$(clear);
lista=$(ls);
listaper=$(ls -l);
listatot=$(ls -a);
total=$(ls | wc -l);
ubiact=$(pwd);
instmp=$(apt-get install mpg123)

#VARIABLES DE USUARIO:
pos=0

#COLORES:
#ROJO=0;31
#AMARILLO=1;33
#AZUL=1;34
#PURPURA=0;35

formato()
{
  #VARIABLES LOCALES:
  cont=0
  rama=0

  #PRINCIPAL:

  #SI EL ARCHIVO ES UNA CARPETA:
  if [ -d "${archivo}" ] && [ $1 -eq 1 ] ; then
    printf "__ \e[1;33m${archivo##*/}\e[0m \n"
    pos=$(($1+4));
    ubiact=${ubiact}/${archivo##*/}
    cd "$ubiact"
    arbol $pos "$ubiact" 1
    cd ..
    ubiact=$(pwd)

  #SI EL ARCHIVO ES DE TIPO MP2:
  elif [ "${archivo##*.}" = "mp2" ]; then
    printf "__ \e[1;35m${archivo##*/}\e[0m \n"

  #SI EL ARCHIVO ES DE TIPO MP3:
  elif [ "${archivo##*.}" = "mp3" ]; then
    printf "__ \e[1;32m${archivo##*/}\e[0m \n"

  #SI EL ARCHIVO ES DE TIPO MP4:
  elif [ "${archivo##*.}" = "mp4" ];then
    printf "__ \e[1;36m${archivo##*/}\e[0m \n"

  #SI EL ARCHIVO ES EJECUTABLE:
  elif [ -x "$archivo" ]; then
    printf "__ \e[1;34m${archivo##*/}\e[0m \n"

  #SI ES UN ARCHIVO COMUN:
  elif [ -f "$archivo" ]; then
    printf "__ ${archivo##*/} \n"

  #SI NO CUENTA CON ARCHIVOS:
  else
    printf "    (Vacio)\n"
  fi

}

arbol()
{
  #VARIABLES LOCALES:
  cont=0
  rama=0
  #band=0

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
      if [ $rama -eq 4 ]; then
        printf "|"
        rama=0
        band=1
      fi
      printf " "

      rama=$(($rama+1))
      cont=$((cont+1))
    done
    rama=0

    formato 1

    cont=0
  done

}

listado()
{
  #VARIABLES LOCALES:
  pos=0

  #PRINCIPAL:
  printf "\n"
  for archivo in "$ubiact"/*; do
    printf "    # $pos"
    formato 0
    pos=$((pos+1))
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
      command clear

      #INGRESAMOS A UNA DE LAS OPCIONES ESCOGIDAS POR EL USUARIO:
      if [ $opcion -eq 1 ]; then
        if [ $(which mpg123) ]; then
          printf "\n\t>>>>>>>>>>>>>> REPRODUCCION DE LA LISTA ACTUAL <<<<<<<<<<<<<<\n\n"
          printf " Directorio actual: \e[1;33m$ubiact\e[0m \n\n"

          cont=1

          for archivo in $ubiact/*.mp3; do
            printf "\n\t$cont. ${archivo##*/}\n\n"
            #my_array[10]="Número 11"
            #echo ${my_array[10]}
            #arreglo[$(($cont-1))]="${archivo##*/}"
            #printf "\n $arreglo[$(($cont-1))]"
            cont=$(($cont+1))
          done

          printf "\n\n Seleccione una opcion:\n"
          printf "\n [ # ]: Reproduce el numero de cancion seleccionado (# - cualquier numero mayor a 0)."
          printf "\n [ * ]: Reproduce todas las canciones de la lista."
          printf "\n [ 0 ]: Reproduce la lista de canciones aleatoramente.\n"
          printf "\n Opcion: "
          read opcion

          if [ $opcion -gt 0 ]; then
            if [ $opcion -le $cont ]; then
              #printf "****** ${arreglo[0]}"
              #command mpg123 "${arreglo[$cont]}"
              printf " "
            else
              printf "\n "
              printf "\n Presion enter para continuar ... "
              read opcion
              opcion=0
            fi

          elif [ "$opcion" = "*" ]; then
            numero=1
            while [ $numero -eq 1 ]; do
              for archivo in "$ubiact"/*; do
                if [ "${archivo##*.}" = "mp3" ]; then
                  command mpg123 "${archivo##*/}"
                fi
              done
              printf "\n La reproduccion de todos los archivos a concluido, desea reiniciar la reproduccion [1 - si / 0 - no]: "
              read numero
              if [ $numero -eq 0 ]; then
                printf "\n Presion enter para continuar ... "
              fi
            done
            opcion=0

          elif [ $opcion -eq 0 ]; then
            printf " -> $ubiact"
            command mpg123 -z "${ubiact}"/*

          else
            clear
            printf "\n\n\n Opcion invalida solo es posible ingresar numeros\n\n Intentelo mas tarde... "
          fi

          read opcion
          opcion=0


          #for archivo in $arreglo; do
            #pos=0
            #SI EL ARCHIVO ES EJECUTABLE:
            #if [ -x $archivo ];then
              #echo " $pos.- \e[1;34m$archivo\e[0m"
              #pos=$((pos+1));
            #fi
          #done

        else
          printf "\n Para iniciar el reproductor es necesario tener instalado mpg123\n"
          printf "\n Desea instalar el reproductor mpg123 [y - si /n - no]: "
          read var
          printf "\n -> $var"
          if [ $var = "y" ]; then
            $instmp
            printf "\n Presione enter para continuar ..."
            read var
            #opcion=0;
          elif [ $var = "n" ]; then
            opcion=0;
          else
            printf "\n ¡Opcion invalida! ..."
          fi
        fi

      fi

      if [ $opcion -eq 2 ]; then
        printf "\n\t>>>>>>>>>>>>>> CAMBIAR DE CARPETA ACTUAL <<<<<<<<<<<<<<\n\n"
        printf " [ / ]           : Directorio raiz (Inaccesible)\n"
        printf " [ ./ ] o [ . ]  : Directorio actual\n"
        printf " [ .. ] o [ ../ ]: Directorio anterior (padre)\n\n"
        printf " Ingrese el nombre o la ruta de la carpeta destino: "
        read nombre

        if [ -d "$nombre" ]; then
          if [ "$nombre" = "/" ]; then
            printf "\n Por su seguridad, no es posible acceder al directorio raiz (/)\n"
            printf "\n Presione enter para continuar ..."
            read opcion
            opcion=0
          else
            cd $nombre
            ubiact=$(pwd)
          fi
        else
          printf "\n El nombre o la direccion de la carpeta destino no existe, intente mas tarde."
          printf "\n Ingrese cualquier tecla para continuar ... "
          read opcion
          opcion=0
        fi
      fi

      if [ $opcion -eq 3 ]; then
        printf "\n\t>>>>>>>>>>>>>> SUBIR CARPETA <<<<<<<<<<<<<<\n\n"
        printf " Ingrese la ruta absoluta de la carpeta que desee agregar a la carpeta actual: "
        read nombre

        if [ -d $nombre ]; then
          mv $nombre $ubiact
        else
          cdprintf "\n El nombre o la direccion de la carpeta destino no existe, intente mas tarde."
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
          listado
        else
          if [ $opcion -eq 2 ]; then
            arbol 0 $ubiact 0
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
        printf " [s] o [space] > Pausar\n"
        printf " [f]           > Siguiente\n"
        printf " [d]           > Previa\n"
        printf " [b]           > Repetir\n"
        printf " [.]           > Adelante\n"
        printf " [a]           > Atras\n"
        printf " [+]           > Subir volumen\n"
        printf " [-]           > Bajar volumen\n"
        printf " [q]           > Quitar reproduccion\n\n"
        printf " Presione cualquier tecla para continuar ... "
        read opcion
        opcion=0;
      fi

    fi

  done

  #LIMPIAMOS LA PANTALLA:
  command clear

}

menuRep
