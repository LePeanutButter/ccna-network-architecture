#!/bin/sh
# Script portable para mostrar logs del sistema
# Compatible con Slackware, Solaris y otros sistemas Unix

clear_screen() {
    # Limpieza de pantalla compatible
    command -v clear >/dev/null 2>&1 && clear
}

mostrar_log() {
    archivo="$1"
    if [ -f "$archivo" ]; then
        echo "Archivo de log: $archivo. Las ultimas 15 lineas son:"
	TAIL_CMD=$(get_tail_command)
	$TAIL_CMD "$archivo"
        echo "-------------------------------------------------------"
    else
        echo "El archivo $archivo no existe."
    fi
}

get_tail_command() {
    # Detecta si el sistema es Solaris
    if uname | grep -qi "sunos"; then
        echo "tail -15"
    else
        echo "tail -n 15"
    fi
}

filtrar_log() {
    archivo="$1"
    palabra="$2"
    if [ -f "$archivo" ]; then
        echo "Archivo de log: $archivo. Con la palabra \"$palabra\" en las ultimas 15 lineas:"
	TAIL_CMD=$(get_tail_command)
	$TAIL_CMD "$archivo" | grep "$palabra"  
        echo "-------------------------------------------------------"
    else
        echo "El archivo $archivo no existe."
    fi
}

# Lista de archivos de log comunes. Puedes modificar según el sistema.
LOGS="
/var/log/messages
/var/log/secure
/var/log/cron
/var/log/dmesg
/var/log/Xorg.0.log
/var/adm/messages
/var/adm/syslog/syslog.log
/var/adm/loginlog
/var/adm/sulog
"


while true; do
    clear_screen
    echo "Menu"
    echo "1. Mostrar las ultimas 15 lineas de los archivos de log"
    echo "2. Mostrar las ultimas 15 lineas que contengan una palabra especifica"
    echo "3. Salir"
    printf "Ingrese una opcion: "
    read opcion

    case "$opcion" in
        1)
            clear_screen
            for log in $LOGS; do
                mostrar_log "$log"
            done
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        2)
            clear_screen
            printf "Ingrese la palabra a buscar: "
            read palabra
            for log in $LOGS; do
                filtrar_log "$log" "$palabra"
            done
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        3)
            clear_screen
            exit 0
            ;;
        *)
            echo "Opcion invalida."
            printf "Presione Enter para continuar..."
            read dummy
            ;;
    esac
done