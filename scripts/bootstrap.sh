#!/bin/bash
ruta="$(pwd)/script.sh"
echo $ruta
echo $ruta
sed -i "s/var/$ruta/g" archivo.txt

#cp servicio.service tempo.timer /etc/systemd/system
