#!/bin/bash

#DIA=`date +"%Y/%m/%d"`
#HORA=`date +"%H:%M"`

#COMPRA=$(curl 127.0.0.1:5000/usd | ../jq .compra)
#VENTA=$(curl 127.0.0.1:5000/usd | ../jq .venta)

#echo "$DIA $HORA, $COMPRA, $VENTA" >> ../historico/historico.txt



CAMBIO=$(stat -c %y sync.txt)

while true
do

NuevoCambio=$(stat -c %y sync.txt)

if [[ $CAMBIO != $NuevoCambio ]]
then

DIA=`date +"%Y/%m/%d"`
HORA=`date +"%H:%M"`

COMPRA=$(curl 127.0.0.1:5000/usd | ../jq .compra)
VENTA=$(curl 127.0.0.1:5000/usd | ../jq .venta)

echo "$DIA $HORA, $COMPRA, $VENTA" >> ../historico/historico.txt



CAMBIO=$(stat -c %y sync.txt)


fi

done
