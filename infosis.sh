#!/bin/bash

memoria_total=`cat /proc/meminfo | grep "MemTotal" | grep "[1-9].*" -o`
memoria_libre=`cat /proc/meminfo | grep "MemFree" | grep "[1-9].*" -o`
memoria_swap=`cat /proc/meminfo | grep "SwapTotal" | grep "[1-9].*" -o`

#Aquí creé éstas variables para no perderme, pero bien se pueden imprimir directamente

SO=`cat /proc/sys/kernel/ostype`
distribucion=`cat /proc/version_signature`
version_kernel=`cat /proc/version | awk {'print $3'}`
modelo_procesador=`cat /proc/cpuinfo | grep "model name"`
velocidad_procesador=`cat /proc/cpuinfo | grep "cpu MHz"`
cache_procesador=`cat /proc/cpuinfo | grep "cache size"`

echo "Información del sistema donde se ejecuta ésta terminal:"

echo -e "La memoria total es de $memoria_total"
echo -e "La memorial disponible es de $memoria_libre"
echo -e "La swap es de $memoria_swap"
echo -e "El sistema operativo es $SO"
echo -e "La distribución de $SO es $distribucion"
echo -e "La versión del kernel es $version_kernel"
echo -e "El modelo de cada procesador es\n$modelo_procesador"
echo -e "La velocidad de cada procesador es\n$velocidad_procesador"
echo -e "El tamaño de la memoria caché de cada procesador es\n$cache_procesador"