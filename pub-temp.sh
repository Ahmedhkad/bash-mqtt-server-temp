#!/usr/ash
# using sh on lightweight alpine but you need to install
# apk update && apk add jq mosquitto-clients

while true
do
# directory for CPU temp
FirstDir="/sys/class/hwmon/hwmon0/"
# directory for GPU
SecondDir="/sys/class/hwmon/hwmon2/"
echo "{\"Server\":\"StrongServer\"" > temp.json
for file in $FirstDir*_input; do
        #echo "filename : ${file##*/}" ;
        ToNumber=${file##*/temp} ;
        onlyNumber=${ToNumber%%_*} ;
        #echo "ToNumber : $onlyNumber "
        CatLabel=$(cat $FirstDir"temp""$onlyNumber""_label")
        CatInput=$(cat $FirstDir"temp""$onlyNumber""_input")
        echo "Temperture of $CatLabel is $((CatInput/1000))"
        echo "," >> temp.json
        echo "\"$CatLabel\":$((CatInput/1000))" >> temp.json
done
CatLabel2=$(cat $SecondDir"in0_label")
CatInput2=$(cat $SecondDir"temp1_input")
echo "," >> temp.json
echo "\"$CatLabe2\":$CatInput2" >> temp.json
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
