#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

#Creado por Milagros Nazaret Lopez C. @milinazaret
#Bajo Licencia GPLv2


# Script que muestra un menu de instalacion de paquetes basicos
# asi como actualizacion y borrado de paquetes no necesarios luego de dicha instalacion




clear


#   Funciones

function menu_principal()
{
    clear
    echo "Selecciona una Opcion:"
    echo
    echo "1) Actualizar Sistema"
    echo "2) Instalar Suite Ofimatica: OpenOffice Idioma Español"
    echo "3) Instalar Navegador Web: Google Chrome "
    echo "4) Instalar Reproductor de Musica y Video: VLC"
    echo "5) Instalar Editor de Texto: Atom"
    echo "6) Instalar Compresor Multiformato: 7zip"
    echo

    echo "9) Salir"

    echo

    echo -n "Indica una opcion: "
  }

#Funcion que Actualiza el Sistema
function actualizar_repositorios()
{
  clear
  apt-get -qq update    #-qq Actualiza en modo silecioso
}

function actualizar_sist()
{
  clear
  echo "Actualizando los Repositorios, puede tardar unos minutos...."
  actualizar_repositorios
  echo "Actualizando los Paquetes, puede tardar unos minutos...."
  apt-get -qq upgrade   #-qq Actualiza en modo silecioso
  echo "Actualización Exitosa!"
}

function limpieza()
{
  clear
  echo "Ejecutando limpieza al Sistema..."
  apt-get -qq autoremove
  apt-get -qq autoclean
  apt-get -qq clean
  echo "Finalizacion de la instalacion"
}

function opcion_escogida()
{
clear
echo "---------------****--------------"
echo " Seleccionaste la Opcion $1"
echo "---------------****--------------"
}

#Hacer mientras La Opcion indicada sea diferente a salir

#recordar validar que deben ser root


until [ "$opc" -eq "9" ];
 do
     case $opc in
       1)
          opcion_escogida $opc
          actualizar_sist
          menu_principal
          ;;

        2)
          opcion_escogida $opc
          add-apt-repository ppa:libreoffice/ppa
          actualizar_repositorios
          apt-get -qq install libreoffice -y
          apt-get -qq install libreoffice-l10n-es -y
          echo "instalacion Exitosa!"
          menu_principal
          ;;

        3)
          opcion_escogida $opc
          wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
          sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
          actualizar_repositorios
          sudo apt-get -qq install google-chrome-stable -y
          echo "instalacion Exitosa!"
          menu_principal
          ;;

        4)
          opcion_escogida $opc
          actualizar_repositorios
          apt-get -qq install vlc browser-plugin-vlc -y
          echo "instalacion Exitosa!"
          menu_principal
          ;;

        5)
          opcion_escogida $opc
          add-apt-repository ppa:webupd8team/atom
          actualizar_repositorios
          apt-get -qq install atom -y
          echo "instalacion Exitosa!"
          menu_principal
          ;;

        6)
          opcion_escogida $opc
          actualizar_repositorios
          apt-get -qq install p7zip-full p7zip-rar rar unrar -y
          echo "instalacion Exitosa!"
          menu_principal
          ;;

         *) # Esta opcion se ejecuta si no es ninguna de las anteriores
          echo "$opc, No es una opcion no Valida, presione enter para regresar al menu"
          read foo
          menu_principal
          ;;


    esac
   read opc

 done

limpieza
