#!/bin/bash
#ruta=$(pwd | sed "s/\//-!/g")

#echo $ruta
#sed -i "s/\/script.sh/$ruta&/g" servicio.service
#sed -i "s/-!/\//g" servicio.service

#cp servicio.service tempo.timer /etc/systemd/system

# Mostrar el menú al usuario
echo "Seleccione una opción:"
echo "1. Instalar"
echo "2. Desinstalar"
echo "3. Salir"

# Leer la opción del usuario
read -p "Opción: " option

# Bucle while para procesar la opción del usuario
while [ "$option" != "3" ]; do
  # Procesar la opción del usuario
  case $option in
    "1")
	ruta=$(pwd)

	sed  "s|var|$ruta|g" template > servicio.service


	sudo cp servicio.service /etc/systemd/system
	sudo cp servicio.timer /etc/systemd/system
	sudo systemctl daemon-reload
	sudo systemctl start servicio.timer
	sudo docker-compose up --build
;;
    "2")
	sudo rm /etc/systemd/system/servicio.service
	sudo rm /etc/systemd/systemo/servicio.timer
;;
    *)
      # Opción inválida
      echo "Opción inválida"
      ;;
  esac

  # Mostrar el menú de nuevo y leer la opción del usuario
  echo "Seleccione una opción:"
  echo "1. Instalar"
  echo "2. Desinstalar"
  echo "3. Salir"
  read -p "Opción: " option
done

# Salir del script
exit 0
