#!/bin/bash

# Script para crear un nuevo usuario con atributos y permisos específicos

# Parámetros pasados al script
nombre=$1              
grupo=$2               
descripcion=$3         
directorio=$4          # Directorio home del usuario
shell=$5               # Shell por defecto del usuario
permisos_usuario=$6    # Permisos para el directorio home del usuario
permisos_grupo=$7      # Permisos para el directorio home del grupo
permisos_otros=$8      # Permisos para el directorio public_html

# Verificar si el shell existe en el sistema
if [ -x "$shell" ]; then

    useradd -m -d "$directorio" -s "$shell" -c "$descripcion" -g "$grupo" "$nombre"
    
    # Asignar permisos al directorio home del usuario
    chmod "$permisos_usuario" "$directorio"

    # Si existe el directorio del grupo, asignar permisos
    if [ -d "/home/$grupo" ]; then
        chmod "$permisos_grupo" "/home/$grupo"
    fi

    # Crear el directorio public_html dentro del home del usuario si no existe
    if [ ! -d "$directorio/public_html" ]; then
        mkdir "$directorio/public_html"
    fi
    
    # Asignar permisos al directorio public_html
    chmod "$permisos_otros" "$directorio/public_html"
    
    # Asignar una contraseña al nuevo usuario
    passwd "$nombre"
    
    clear

    # Verificar si el usuario fue creado exitosamente
    if id "$nombre" &>/dev/null; then
        echo "Usuario creado exitosamente"
    else
        echo "El usuario no pudo ser creado"
    fi

else
    # Si el shell no existe en /etc/shells, abortar creación
    clear
    echo "El shell no existe o no esta instalado, el usuario no pudo ser creado"
fi
