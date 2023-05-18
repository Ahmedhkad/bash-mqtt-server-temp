#!/usr/ash


for file in /sys/class/hwmon/*/*_input; do 
        CatInput=$(cat $file)
       echo "$file is $CatInput"
done


for file2 in /sys/class/hwmon/*/*_label; do
        CatInput2=$(cat $file2)
       echo "$file2 is $CatInput2"                                           
done   