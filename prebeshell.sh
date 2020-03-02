#!/bin/bash

RESET="\033[0m"
NEGRITA="\033[1m"
AMARILLO="\033[38;5;11m"
AZUL="\033[0;34m"
NARANJA="\033[0;33m"

trap "" 2 20
trap "" SIGTSTP  #anula Ctrl + C   y  Ctrl + Z

clear

while true; do
    echo -e -n "$AMARILLO User: $AZUL" 
    read usuario
    echo -e -n "$AMARILLO Contraseña: $AZUL"
    read -s contramarca   

    linea=`sudo -S grep -r $usuario /etc/shadow`

    if true; then 

        IFS='$' read -r -a array <<< "$linea"  

        index="\$${array[1]}\$${array[2]}"
        hash=`python -c 'import crypt; import sys; print crypt.crypt( sys.argv[1] , sys.argv[2])' $contramarca $index`

        match=`echo "$linea" | grep -c "$hash"`


        if [ "$match" -eq 1 ]; then
            clear

            #ENTRAMOS A LA PREBESHELL

			echo -e "\t\t\t$NARANJA$NEGRITA**********Bienvenido a la prebeshell humano**********\n$RESET"
			echo -e "Escribe la palabra \"ayuda\" para conocer las funciones "
			echo -e "La unica manera de salir de la prebeshell es con el comando \"salir\"  \n"


            contador_salida=0

			while [ $contador_salida -eq 0 ];
			do

				read -p "$(echo -e "$NEGRITA$AMARILLO$USER:$NEGRITA$AZUL$PWD$RESET"$ "" )" comando

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
					'reproductor')
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
        else
            echo -e "$NARANJA Contrasena incorrecta"
            let fails--
        fi
    else
        let fails--
    fi
done
