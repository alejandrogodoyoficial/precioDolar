#!/bin/bash
ruta=$(pwd | sed "s/\//-!/g")

echo $ruta
sed -i "s/\/script.sh/$ruta&/g" servicio.service
sed -i "s/-!/\//g" servicio.service

cp servicio.service tempo.timer /etc/systemd/system
