#!/bin/bash
clear
echo -e "\e[1;36mLa hora actual es \e[1;3;91m"
cat /proc/driver/rtc | grep "rtc_time*" | grep "[0-9]*:[0-9]*:[0-9]*" -o 

<< COMMENT

El directorio / proc / driver contiene información para controladores 
específicos en uso por el núcleo. Un archivo común que se encuentra aquí es 
rtc que proporciona la salida del controlador para el reloj de tiempo real 
(RTC) del sistema, el dispositivo que mantiene la hora mientras el sistema 
está apagado.

El grep sirve para delimitar la impresión que hace cat para que solo se 
muestre la hora

COMMENT
