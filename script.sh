#!/bin/bash
# -*- ENCODING: UTF-8 -*-
LC_ALL=C

#Creado por Milagros Nazaret Lopez C. @milinazaret
#Bajo Licencia GPLv2


# Script que muestra un menu de instalacion de paquetes basicos
# asi como actualizacion y borrado de paquetes no necesarios luego de
#dicha instalacion


#************************ Definicion de Funciones ************************

#Funcion que genera el menu de opciones
function menu_principal()
{
    clear
    echo "Selecciona una Opcion:"
    echo
    echo "1) Actualizar Sistema"
    echo "2) Instalar editor de video: Openshot"
    echo "3) Instalar aplicación para capturas de imágenes o videos con cámara web: Shutter "
    echo "4) Instalar reproductor de música y video: VLC"
    echo "5) Instalar editor de texto: Atom"
    echo "6) Instalar editor de imágenes: Gimp"
    echo "7) Limpieza de paquetes y archivos no necesarios"
    echo
    echo "9) Salir"
    echo
    echo -n "Indica una opción [1...9]: "
  }

#Funcion que Actualiza el Sistema
function actualizar_repositorios()
{
    apt-get -qq update    #-qq Actualiza en modo silecioso
}

#Funcion que Actualiza los repositorios y paquetes
function actualizar_sist()
{
    echo "Actualizando los Repositorios, puede tardar unos minutos...."
    actualizar_repositorios
    echo "Actualizando los Paquetes, puede tardar unos minutos...."
    apt-get -qq upgrade   #-qq Actualiza en modo silecioso
    echo "Actualizando el Kernel, puede tardar unos minutos..."
    apt-get -qq dist-upgrade
    echo "Actualización Exitosa!"
}

#Funcion que muestra la opcion elegida
function opcion_escogida()
{
    clear
    echo "------------------****------------------"
    echo " Seleccionaste la opción $1"
    echo "------------------****------------------"
}


#Funcion que valida si tiene internet activo
function internet_activo()
{
   ping -c3 google.com &>/dev/null
    if [ "$?" -ne 0 ]
      then
        echo
        echo "Se requiere tener conexión a internet"
        echo
        echo
        exit 1
    fi
}

#************************ Culminacion de las Funciones ************************


#Validar que el usuario sea root

if [ $USER != root ]; then
  echo -e "Este script debe ser utilizado como 'root'"
  echo -e "Saliendo..."
  exit 0
fi

while :
do
  menu_principal
  read opc
  case $opc in

     0)
       menu_principal
       ;;

     1)
       opcion_escogida $opc
       internet_activo
       actualizar_sist
       menu_principal
       ;;

     2)
       opcion_escogida $opc
       internet_activo
       actualizar_repositorios
       apt-get -qq install openshot kazam -y
       echo "Instalación Exitosa!"
       menu_principal
       ;;

     3)
       opcion_escogida $opc
       internet_activo
       actualizar_repositorios
       apt-get -qq install shutter -y
       echo "Instalación Exitosa!"
       menu_principal
       ;;

     4)
       opcion_escogida $opc
       internet_activo
       actualizar_repositorios
       apt-get -qq install vlc browser-plugin-vlc -y
       echo "Instalación Exitosa!"
       menu_principal
       ;;

     5)
       opcion_escogida $opc
       internet_activo
       add-apt-repository ppa:webupd8team/atom
       actualizar_repositorios
       apt-get -qq install atom -y
       echo "Instalación Exitosa!"
       menu_principal
       ;;

     6)
       opcion_escogida $opc
       internet_activo
       actualizar_repositorios
       apt-get -qq install gimp -y
       apt-get -qq install gimp-help-es -y
       echo "Instalación Exitosa!"
       menu_principal
       ;;

     7)
       opcion_escogida $opc
       echo "Ejecutando limpieza al Sistema..."
       apt-get -qq autoremove -y
       apt-get -qq autoclean
       apt-get -qq clean
       echo "Sistema Limpio"
       menu_principal
       ;;

     9)
       opcion_escogida $opc
       echo "Saliendo del Script..."
       exit 1
       ;;


    *) # Esta opcion se ejecuta si no es ninguna de las anteriores
      echo "$opc no es una opcion válida.";
      echo "Presiona una tecla para continuar...";
      read opc;;
 esac


done
exit 0
