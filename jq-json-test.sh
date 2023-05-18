#!/usr/ash

server=$(jq -r '.Server' ./secret.ini)
user=$(jq -r '.User' ./secret.ini)
password=$(jq -r '.Password' ./secret.ini)
echo "the server is $server"
echo "user is $user and pass is $password"