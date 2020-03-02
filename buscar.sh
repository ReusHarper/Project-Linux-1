read -p "Nombre del archivo que se desea buscar: " nombre_archivo
read -p "Nombre del directorio donde se encuentra: " direccion
find $direccion | grep "$nombre_archivo"
