#!/bin/bash


RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
BLUE="\033[0;34m"

while read -p "$(echo  $BOLD$YELLOW"$USER:"$BOLD$BLUE"$PWD"$RESET"$ ")" variable 
do 
   command $variable
done

