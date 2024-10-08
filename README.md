# Tareas prácticas Linux

## Índice

- [Sección 5](#sección-5)
- [Sección 6](#sección-6)
- [Sección 7](#sección-7)
- [Sección 15](#sección-15)

---

## Sección 5

Utiliza el comando `find` para buscar los siguientes ficheros dentro de Linux.

**Preguntas de esta tarea**

1. Busca la ruta donde se encuentra el comando externo `ls` utilizando `find`. Asegúrate de eliminar los mensajes de acceso denegado que produzca el comando.
   * Rta.: `find / -name ls -executable 2> /dev/null`

2. Busca directorios de configuración del programa `firefox` que viene instalado por defecto en Ubuntu. El nombre de los directorios debe ser `firefox` (igual que el programa).
   * Rta.: `find / -type d -name firefox 2> /dev/null`

3. Busca el usuario propietario del fichero `shadow` que se encuentra en algún lugar del sistema de ficheros de Linux excluyendo aquellos ficheros `shadow` que se encuentren dentro de la ruta `/snap`.
   * Rta.: `find / -path /snap -prune -o -name shadow -exec ls -l {} \; 2> /dev/null`

---

## Sección 6

Utiliza los wildcards presentados en la sección anterior para realizar las siguientes búsquedas de ficheros y directorios.

**Preguntas de esta tarea**

1. Busca todos los ficheros que se encuentran en `/usr/bin` y terminan por un número.
   * Rta.: `find /usr/bin -type f -name "*[[:digit:]]" 2> /dev/null`

2. Busca todos los ficheros en el sistema de ficheros de Linux que contenga dos caracteres `_` en el nombre y terminen en `.txt`.
   * Rta.: `find / -type f -name "*_*_*.txt" 2> /dev/null`

3. Busca todos los ficheros en `/var/log` que no terminen en `.log`
   * Rta.: `find /var/log -type f ! -name "*.log" 2> /dev/null`

---

## Sección 7

Completa las siguientes actividades utilizando las herramientas de filtrado y búsqueda de información que se han presentado en los temas anteriores.

**Preguntas de esta tarea**

1. Muestra por pantalla todos los archivos y directorios que tienes en tu directorio de trabajo ordenados por tamaño.
   * Rta.: ordenar de menor a mayor tamaño:
     ```
     ls -l | sort -k5 -n
     ```
   * ordenar de menor a mayor tamaño incluyendo archivos ocultos:
     ```
     ls -la | sort -k5 -n
     ```

2. Crea un nuevo fichero en tu sistema Linux ejecutando el siguiente comando:

    ```
    echo -e "rojo,1,coche,madrid\nazul,4,moto,mexico\namarillo,2,bicicleta,paris\nverde,6,avion,roma" > fichero.csv
    ```
Ordena el fichero que acabas de crear (`fichero.csv`) por el segundo campo teniendo en cuenta que los campos están separados por el delimitador
* Rta.: `sort -t ',' -nk2 fichero.csv`

3. Muestra por pantalla la línea 55 del fichero `auth.log` que se encuentra en `/var/log`
* Rta.: `head -n 55 /var/log/auth.log | tail -n 1`

---

## Sección 15

Completa los siguientes ejercicios relacionados con expresiones regulares básicas.

**Preguntas de esta tarea**

1. Crea un fichero llamado `datos_usuarios.txt` que contenga la siguiente información:
El telefono 5551212 pertenece a Juan

El telefono (+34)5551213 pertenece a Sonia

El telefono 5551214 pertenece a Pedro

El telefono (+32)5551215 pertenece a Lucia

El telefono (+33)5551216 pertenece a Marta

El telefono (+34)5551217 pertenece a Alberto


2. Implementa una expresión regular que permita identificar aquellos números de teléfono que tienen un prefijo (ej. (+33)5551216)
* Rta.: `grep -E '\(\+[0-9]+\)[0-9]*' datos_usuarios.txt`
* Resultado:
  ```
  El telefono (+34)5551213 pertenece a Sonia
  El telefono (+32)5551215 pertenece a Lucia
  El telefono (+33)5551216 pertenece a Marta
  El telefono (+34)5551217 pertenece a Alberto
  ```

3. Combina las capacidades de las expresiones regulares junto con las del comando `sed` para eliminar los prefijos del fichero `datos_usuarios.txt` creado en la tarea anterior.
* Rta.: `sed -E 's/\(\+[0-9]+\)//g' datos_usuarios.txt > datos_usuarios_sin_prefijos.txt`
* Resultado:
  ```
  El telefono 5551212 pertenece a Juan
  El telefono 5551213 pertenece a Sonia
  El telefono 5551214 pertenece a Pedro
  El telefono 5551215 pertenece a Lucia
  El telefono 5551216 pertenece a Marta
  El telefono 5551217 pertenece a Alberto
  ```
