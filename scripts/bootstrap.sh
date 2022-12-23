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
echo "3. Ejecutar"
echo "4. Salir"

# Leer la opción del usuario
read -p "Opción: " option

# Bucle while para procesar la opción del usuario
while [ "$option" != "4" ]; do
  # Procesar la opción del usuario
  case $option in
    "1")
	ruta=$(pwd | sed "s/\//-!/g")

	sed -i "s/script.sh/$ruta&/g" servicio.service
	sed -i "s/-!/\//g" servicio.service

	sudo cp servicio.service /etc/systemd/system
	sudo cp tempo.timer /etc/systemd/system
	sudo systemcl daemon-reload
	sudo systemctl start servicio.timer
	sudo docker-compose up --build
;;
    "2")
	sudo rm /etc/systemd/system/servicio.service
	sudo rm /etc/systemd/systemo/tempo.timer
;;
    "3")
	sudo docker-compose up -d
	../cotizacion-bna/cotizacion_api.py &
	./script.sh &
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
  echo "3. Ejecutar"
  echo "4. Salir"
  read -p "Opción: " option
done

# Salir del script
exit 0
