#!/bin/sh

# Script compatible con sistemas Unix (Slackware, Solaris, etc.)

clear_screen() {
    command -v clear >/dev/null 2>&1 && clear
}

contar_palabra_en_archivo() {
    archivo="$1"
    palabra="$2"

    if [ -f "$archivo" ]; then
        if grep "$palabra" "$archivo" >/dev/null 2>&1; then
            # Imprimir líneas donde aparece con número de línea
            grep -n "$palabra" "$archivo"

            # Contar ocurrencias de palabra en todo el archivo (sin usar -o ni awk)
            cantidad=$(grep "$palabra" "$archivo" | tr ' ' '\n' | grep -w "$palabra" | wc -l)
            echo "Numero de veces que se repitio: $cantidad"
        else
            echo "La palabra \"$palabra\" no fue encontrada en $archivo."
        fi
    else
        echo "El archivo \"$archivo\" no existe."
    fi
}


while true; do
    clear_screen
    echo "Menúu"
    echo "1. Mostrar ruta del archivo y numero de apariciones en un directorio"
    echo "2. Mostrar una palabra en un archivo y el numero de veces que se repite"
    echo "3. Mostrar la linea donde se encontro la palabra y numero de repeticiones por archivo"
    echo "4. Contar el numero de lineas de un archivo"
    echo "5. Mostrar las primeras n lineas de un archivo"
    echo "6. Mostrar las ultimas n lineas de un archivo"
    echo "7. Salir"
    printf "Ingrese una opcion: "
    read opcion

    case "$opcion" in
        1)
            clear_screen
            printf "Ingrese una ruta: "
            read ruta
            printf "Ingrese un nombre de archivo (patron): "
            read archivo
            find "$ruta" -type f -iname "*$archivo*" 2>/dev/null
            cantidad=$(find "$ruta" -type f -iname "*$archivo*" 2>/dev/null | wc -l)
            echo "Numero de archivos encontrados: $cantidad"
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        2)
            clear_screen
            printf "Ingrese el nombre de un archivo: "
            read archivo
            printf "Ingrese una palabra: "
            read palabra
            contar_palabra_en_archivo "$archivo" "$palabra"
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        3)
            clear_screen
            printf "Ingrese una ruta: "
            read ruta
            printf "Ingrese un patron de archivo: "
            read patron
            printf "Ingrese una palabra: "
            read palabra

            archivos=$(find "$ruta" -type f -iname "*$patron*" 2>/dev/null)

            for archivo in $archivos; do
                grep "$palabra" "$archivo" >/dev/null 2>&1
                if [ $? -eq 0 ]; then
                    echo "===> ARCHIVO: $archivo <==="
                    contar_palabra_en_archivo "$archivo" "$palabra"
                fi
            done
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        4)
            clear_screen
            printf "Ingrese la ruta de un archivo: "
            read archivo
            if [ -f "$archivo" ]; then
                lineas=$(wc -l < "$archivo")
                echo "El numero de líneas en el archivo es: $lineas"
            else
                echo "El archivo no existe."
            fi
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        5)
            clear_screen
            printf "Ingrese la ruta de un archivo: "
            read archivo
            if [ -f "$archivo" ]; then
                printf "¿Cuantas lineas desea mostrar?: "
                read n
                echo "Primeras $n lineas del archivo: $archivo"
                head -"$n" "$archivo" | more
            else
                echo "El archivo no existe."
            fi
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        6)
            clear_screen
            printf "Ingrese la ruta de un archivo: "
            read archivo
            if [ -f "$archivo" ]; then
                printf "¿Cuantas lineas desea mostrar?: "
                read n
                echo "Ultimas $n lineas del archivo: $archivo"
                tail -"$n" "$archivo" | more
            else
                echo "El archivo no existe."
            fi
            printf "Presione Enter para continuar..."
            read dummy
            ;;
        7)
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
