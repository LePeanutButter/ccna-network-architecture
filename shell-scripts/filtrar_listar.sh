#!/bin/bash

# Función para listar archivos/directorios/enlaces en la ruta (profundidad 1)
list_items() {
    # Expande archivos visibles y ocultos (.*, *) evitando . y ..
    for f in "$1"/* "$1"/.*; do
        # Evita . y ..
        base=$(basename "$f")
        [ "$base" = "." ] && continue
        [ "$base" = ".." ] && continue
        # Solo si existe (evita error si no hay archivos ocultos)
        [ -e "$f" ] || continue
        echo "$f"
    done
}

# Función para obtener fecha en YYYYMMDD usando stat compatible
get_date() {
    f="$1"
    if stat -f "%Sm" -t "%Y%m%d" "$f" >/dev/null 2>&1; then
        stat -f "%Sm" -t "%Y%m%d" "$f"
    else
        stat --format="%y" "$f" 2>/dev/null | cut -c1-10 | tr -d '-'
    fi
}

# Función para obtener tamaño en bytes
get_size() {
    f="$1"
    wc -c <"$f" 2>/dev/null
}

# Inicio del script
if [ -z "$1" ]; then
    echo "Uso: $0 <ruta>"
    exit 1
fi

ruta=$1

if [ ! -d "$ruta" ]; then
    echo "La ruta no es un directorio valido."
    exit 1
fi

while :; do
    echo "Menu"
    echo "1. Ordenar por caracteristica"
    echo "2. Ordenar por condiciones"
    echo "3. Salir"

    printf "Ingrese una opcion: "
    read opcion

    case "$opcion" in
        1)
            echo "1. Ordenar archivos por mas recientes (fecha solo)"
            echo "2. Ordenar archivos por mas antiguos (fecha solo)"
            echo "3. Ordenar archivos de mayor a menor tamano"
            echo "4. Ordenar archivos de menor a mayor tamano"
            echo "5. Ordenar archivos por tipo (archivo, directorio, enlace)"

            printf "Ingrese una opcion: "
            read subopcion

            case "$subopcion" in
                1)
                    list_items "$ruta" | while IFS= read -r f; do
    			fecha=$(get_date "$f")
    			echo "$fecha $f"
		    done | sort -r | tee /tmp/listado.tmp | cut -d' ' -f2-
 
		    echo ""
		    echo "Conteo por fecha:"
		    cut -d' ' -f1 /tmp/listado.tmp | sort | uniq -c | sort -rn
		    rm -f /tmp/listado.tmp
                    ;;
                2)
                    list_items "$ruta" | while IFS= read -r f; do
    			fecha=$(get_date "$f")
    			echo "$fecha $f"
		    done | sort | tee /tmp/listado.tmp | cut -d' ' -f2-
 
		    echo ""
		    echo "Conteo por fecha:"
		    cut -d' ' -f1 /tmp/listado.tmp | sort | uniq -c | sort -rn
		    rm -f /tmp/listado.tmp
                    ;;
                3)
                    list_items "$ruta" | while IFS= read -r f; do
                        if [ -f "$f" ]; then
                            size=$(get_size "$f")
                            echo "$size $f"
                        fi
                    done | sort -rn | cut -d' ' -f2-
                    ;;
                4)
                    list_items "$ruta" | while IFS= read -r f; do
                        if [ -f "$f" ]; then
                            size=$(get_size "$f")
                            echo "$size $f"
                        fi
                    done | sort -n | cut -d' ' -f2-
                    ;;
                5)
                    archivos_total=0
                    directorios_total=0
                    enlaces_total=0
                    list_items "$ruta" | while IFS= read -r f; do
                        if [ -f "$f" ]; then
                            archivos_total=$((archivos_total + 1))
                        elif [ -d "$f" ]; then
                            directorios_total=$((directorios_total + 1))
                        elif [ -L "$f" ]; then
                            enlaces_total=$((enlaces_total + 1))
                        fi
                    done
                    # Para evitar problema con subshell del while, usamos for:
                    archivos_total=0
                    directorios_total=0
                    enlaces_total=0
                    for f in "$ruta"/* "$ruta"/.*; do
                        base=$(basename "$f")
                        [ "$base" = "." ] && continue
                        [ "$base" = ".." ] && continue
                        [ -e "$f" ] || continue
                        if [ -f "$f" ]; then
                            archivos_total=$((archivos_total + 1))
                        elif [ -d "$f" ]; then
                            directorios_total=$((directorios_total + 1))
                        elif [ -L "$f" ]; then
                            enlaces_total=$((enlaces_total + 1))
                        fi
                    done
                    echo "Archivos: $archivos_total"
                    echo "Directorios: $directorios_total"
                    echo "Enlaces: $enlaces_total"
                    ;;
                *)
                    echo "Opcion no valida."
                    ;;
            esac
            ;;
        2)
            clear
            printf "Incluir subdirectorios? (s/n): "
            read recursivo

            echo "1. Mostrar archivos que comienzan con una cadena"
            echo "2. Mostrar archivos que terminan con una cadena"
            echo "3. Mostrar archivos que contienen una cadena"

            printf "Ingrese una opcion: "
            read subopcion2

            printf "Ingrese la cadena: "
            read cadena

            if [ "$recursivo" = "s" ]; then
                # Recursivo
                case "$subopcion2" in
                    1) find "$ruta" -type f -name "${cadena}*" ;;
                    2) find "$ruta" -type f -name "*${cadena}" ;;
                    3) find "$ruta" -type f -name "*${cadena}*" ;;
                    *) echo "Opcion no valida." ;;
                esac
            else
                # No recursivo: listar archivos en ruta que cumplen patrón
                # Listamos con for y comprobamos con shell pattern matching
                for f in "$ruta"/* "$ruta"/.*; do
                    base=$(basename "$f")
                    [ "$base" = "." ] && continue
                    [ "$base" = ".." ] && continue
                    [ -f "$f" ] || continue
                    case "$subopcion2" in
                        1)
                            case "$base" in
                                "$cadena"*) echo "$f" ;;
                            esac
                            ;;
                        2)
                            case "$base" in
                                *"$cadena") echo "$f" ;;
                            esac
                            ;;
                        3)
                            case "$base" in
                                *"$cadena"*) echo "$f" ;;
                            esac
                            ;;
                        *)
                            echo "Opcion no valida." ;;
                    esac
                done
            fi
            ;;
        3)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opcion no valida."
            ;;
    esac
done
