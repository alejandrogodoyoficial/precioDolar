#!/bin/bash
DIA=`date +"%Y/%m/%d"`
HORA=`date +"%H:%M"`



COMPRA=$(curl 127.0.0.1:5000/usd | ../jq .compra)
VENTA=$(curl 127.0.0.1:5000/usd | ../jq .venta)



echo "AAAA-MM-AA,HH:MM,Precio Compra,Precio Venta" >> ../historico/historico.txt
echo "$DIA $HORA,$COMPRA,q$VENTA" >> ../historico/historico.txt





