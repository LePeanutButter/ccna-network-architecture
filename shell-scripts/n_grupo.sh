#!/bin/sh
# Script para crear un grupo en Linux (Slackware) o Solaris

if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_grupo> <id_grupo>"
    exit 1
fi

nombre_grupo=$1
id_grupo=$2

# Verificar si el grupo ya existe
if grep "^$nombre_grupo:" /etc/group >/dev/null 2>&1; then
    echo "Error: El grupo '$nombre_grupo' ya existe."
    exit 1
fi

# Detectar sistema operativo
SO=$(uname -s)

if [ "$SO" = "SunOS" ]; then
    # Solaris usa -g
    if groupadd -g "$id_grupo" "$nombre_grupo"; then
        echo "Grupo '$nombre_grupo' creado exitosamente en Solaris con GID $id_grupo"
    else
        echo "No se pudo crear el grupo '$nombre_grupo' en Solaris"
        exit 1
    fi
else
    # Linux (Slackware u otras distros) usa --gid
    if groupadd --gid "$id_grupo" "$nombre_grupo"; then
        echo "Grupo '$nombre_grupo' creado exitosamente en Linux con GID $id_grupo"
    else
        echo "No se pudo crear el grupo '$nombre_grupo' en Linux"
        exit 1
    fi
fi
