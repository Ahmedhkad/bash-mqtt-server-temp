#!/usr/ash
# using sh on lightweight alpine but you need to install
# apk update && apk add jq mosquitto-clients
rm ./temp.json
while true
do
echo "{\"Server\":\"StrongServer\"" > temp.json
for file in /sys/class/hwmon/hwmon0/*_input; do
        #echo "filename : ${file##*/}" ;
        ToNumber=${file##*/temp} ;
        onlyNumber=${ToNumber%%_*} ;
        #echo "ToNumber : $onlyNumber "
        CatLabel=$(cat /sys/class/hwmon/hwmon0/"temp""$onlyNumber""_label")
        CatInput=$(cat /sys/class/hwmon/hwmon0/"temp""$onlyNumber""_input")
        echo "Temperture of $CatLabel is $((CatInput/1000))"
        echo "," >> temp.json
        echo "\"$CatLabel\":$((CatInput/1000))" >> temp.json
done
echo "}" >> temp.json
# Publish Data
server=$(jq -r '.Server' ./secret.ini)
user=$(jq -r '.User' ./secret.ini)
password=$(jq -r '.Password' ./secret.ini)
topic=$(jq -r '.Topic' ./secret.ini)
mosquitto_pub -h $server -u $user -P $password -t $topic -f ./temp.json
interval="${1:-60}"
echo "repeating next $interval seconds..."
  sleep $interval
done
