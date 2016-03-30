#!/bin/bash
# -*- ENCODING: UTF-8 -*-

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
    echo "2) Instalar Editor de Video: Openshot"
    echo "3) Instalar Aplicación para Capturas de imágenes o videos con web cams: Shutter "
    echo "4) Instalar Reproductor de Música y Video: VLC"
    echo "5) Instalar Editor de Texto: Atom"
    echo "6) Instalar Editor de Imágenes: Gimp"
    echo "7) Limpieza de paquetes y archivos no necesarios"
    echo
    echo "9) Salir"
    echo
    echo -n "Indica una opcion [1...9]: "
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
echo "---------------****--------------"
echo " Seleccionaste la Opción $1"
echo "---------------****--------------"
}



#************************ Culminacion de las Funciones ************************


#Validar que el usuario sea root

if [ $USER != root ]; then
  echo -e "Este script debe ser utilizado como 'root'"
  echo -e "Saliendo..."
  exit 0
fi


#Hacer mientras La Opcion indicada sea diferente a salir

opc=0 #inicializando opc a cero por defecto

until [ "$opc" -eq "9" ];
 do
     case $opc in

        0)
          menu_principal
          ;;

        1)
          opcion_escogida $opc
          actualizar_sist
          menu_principal
          ;;

        2)
          opcion_escogida $opc
          actualizar_repositorios
          apt-get -qq install openshot kazam -y
          echo "Instalación Exitosa!"
          menu_principal
          ;;

        3)
          opcion_escogida $opc
          actualizar_repositorios
          apt-get -qq install shutter -y
          echo "Instalación Exitosa!"
          menu_principal
          ;;

        4)
          opcion_escogida $opc
          actualizar_repositorios
          apt-get -qq install vlc browser-plugin-vlc -y
          echo "Instalación Exitosa!"
          menu_principal
          ;;

        5)
          opcion_escogida $opc
          add-apt-repository ppa:webupd8team/atom
          actualizar_repositorios
          apt-get -qq install atom -y
          echo "Instalación Exitosa!"
          menu_principal
          ;;

        6)
          opcion_escogida $opc
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

       *) # Esta opcion se ejecuta si no es ninguna de las anteriores
          echo "$opc, Opción no Válida, intente nuevamente... "
          read opc
          menu_principal
          ;;
    esac

  read opc

 done
