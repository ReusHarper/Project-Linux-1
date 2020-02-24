#!/bin/bash

#Estos son los valores de los contenidos que puede tener cada partición del gato 
vacio=0
x=1
o=2

#Estos son los símbolos que REPRESENTARAN los valores en el tablero, i. e., son lo que se verá en la pantalla
representacion_vacio=' '
representacion_x='X'
representacion_o='O'

#Crear varialbes {casilla1,casilla2,casilla3,casilla4,casilla5,casilla6,casilla7,casilla8,casilla9} 
#que representen cada posición en orden ascendente de IZQUIERDA a DERECHA y de ARRIBA hacia ABAJO 
#al mismo tiempo que se les inicializa como "vacías"

inicializacion_tablero (){
	for j in `seq 1 9`; do 
		eval casilla$j=$vacio
	done
}

<<COMENTARIO
☠En la línea 17:
*"j" es la variable que tomará los diferentes valores contenidos en $ (ls). 
*"seq" es el comando que se usa para generar números del PRIMERO=1 a ÚLTIMO=9 en pasos de INCREMENTO que por defecto es 1.
*Los acentos graves funcionan para primero ejecutar el comando y poner en una cadena lo que resultó
☠En la tercera línea
*"eval" usa para ejecutar un comando aunque éste este dentro de una cadena
☠En la línea cuatro 
*"done" indica que el código que usó el valor de $i ha terminado y $i puede tomar un nuevo valor
COMENTARIO

#$* son todos los parámetros del script o función, divididos en argumentos separados en espacios en blanco
#para más información de $* https://unix.stackexchange.com/questions/141287/what-does-mean-in-shell

impresion_ordenada () {
    	echo -e "$*"
}

#Imprimir el tablero, las figuras son emojis de WhatsApp 

imprimir_tablero() {
    impresion_ordenada "\n $casilla1❗$casilla2 ❗$casilla3 \n➖💀➖💀➖\n $casilla4❗$casilla5 ❗$casilla6 \n➖💀➖💀➖\n $casilla7❗$casilla8 ❗$casilla9 \n" \
	| tr $vacio$x$o "$representacion_vacio$representacion_x$representacion_o"
}


#La siguiente función lista los recuadros del tablero que están vacíos 
#Es usada más adelante para saber cuando hay un empate
#Aquí "test" esta comparando dos cadenas (aunque puede comparar más cosas) y por ello
#El \c mantiene el cursor en la misma línea después del final del echo

casillas_vacias () {
	for j in `seq 1 9`; do  
		eval test '$casilla'$j -eq $vacio && impresion_ordenada $j' \c'
	done 
}

#La presente función checa si un jugador a ganado o si el tablero está lleno y en cualquier
#caso lo muestra en la pantalla

finalizacion () {
	ganador=$vacio
	combinaciones_ganadoras='123 456 789 147 258 369 159 357'

	for combinacion_ganadora in $combinaciones_ganadoras; do
	
	if test $ganador -ne $vacio; then
	    break
	fi

	primer_posicion=`expr substr $combinacion_ganadora 1 1`
	segunda_posicion=`expr substr $combinacion_ganadora 2 1`
	tercer_posicion=`expr substr $combinacion_ganadora 3 1`
	
	if eval test '$casilla'$primer_posicion '-ne' $vacio '-a' '$casilla'$primer_posicion '-eq' '$casilla'$segunda_posicion '-a' '$casilla'$primer_posicion '-eq' '$casilla'$tercer_posicion; then
	   eval ganador='$casilla'$primer_posicion
	fi
    done

#La bandera -ne checa que dos ENTEROS no sean iguales 
#Luego se acaba el proceso diciendo que el proceso fue exitoso 

    if test $ganador -ne $vacio; then
	echo "Felicidades $ganador, tú ganas" | tr $x$o "$representacion_x$representacion_o"
	return 0
    fi

#En la línea # se prueba (test -z) la longitud de la cadena que contiene las casillas vacias sea cero lo cual 
#equivale a que no haya casillas vacías, i. e., que este lleno el tablero
 
    if test -z "`casillas_vacias`"; then
	echo "Fue un empate"
	return 0
    fi

    return 1
}

<<COMENTARIO
💀El comando "expr" evalúa una expresión dada y muestra su salida correspondiente. Se utiliza para:
* Operaciones básicas como suma, resta, multiplicación, división y módulo en enteros.
* Evaluación de expresiones regulares, operaciones de cadena como subcadena, longitud de cadenas, etc.
Por ejemplo: expr substr $x 2 3 extrae tres caracteres empezando desde el segundo (incluyendo el segundo)
💀El comando return se usa para salir de una función de shell. Toma un parámetro [N], si se menciona N, 
devuelve [N] y, si no se menciona N, devuelve el estado del último comando ejecutado dentro de la función o script. 
N solo puede ser un valor numérico.
COMENTARIO

#La siguiente función obtiene la respuesta del usuario a cada jugada 


jugada_usuario (){
	while true; do
		impresion_ordenada `echo $1 | tr $x$o "$representacion_x$representacion_o"`", selecciona una casilla vacia de la 1 a la 9: \c"
		read jugada
		if expr "$jugada" : '[1-9]$' > /dev/null && ejecutar_jugada $jugada $1; then
			return
		else
			echo "Elección invalida"
		fi
	done
}

#La siguiente función "ejecuta" la jugada de cada jugador, por supuesto que antes debe recibir la elección
#ésta ejecución se traduce en asignar el número a la casilla correspondiente (la elección)

ejecutar_jugada (){
	#primero hay que checar que el recuadro no este ocupado, si lo ésta en la función jugar va a decir que es una 
	#elección inválida
	if eval test '$casilla'$1 -ne '$vacio'; then 
		return 1
	fi
	eval casilla$1=$2 #Aquí se remplaza al valor de la casilla con el nuevo
}


#La siguiente función ya es el juego con su configuración e inicialización 

jugar (){

#Preámbulo 
	preambulo="Hora de jugar gato"
	impresion_ordenada $preambulo
	impresion_ordenada "\nEl tablero esta ordenado de la siguiente manera\n 1❗2 ❗3 \n➖💀➖💀➖\n 4❗5 ❗6 \n➖💀➖💀➖\n 7❗8 ❗9 \n"

	movidas=0
	inicializacion_tablero

	while true; do
		
		jugada_usuario $x
		movidas=`expr $movidas + 1`
		imprimir_tablero

#Para cuando hayamos terminado hay que volver al principio 

		if finalizacion; then
	    	return
		fi

		jugada_usuario $o
		movidas=`expr $movidas + 1`
		imprimir_tablero
    
		if finalizacion ; then
	    	return
		fi

    done
}
	
jugar