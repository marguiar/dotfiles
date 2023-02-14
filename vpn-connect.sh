#!/bin/bash

# This script autoconnects a vpn.

# pegar o nome da VPN: `nmcli con | grep -i vpn`
VPN_NAME=Fintools # VPN da fintools

VPN_RETRY_TIME=2
MAX_RETRIES=30

nmcli con up $VPN_NAME
SUCCESS=($? = 0)

ATTEMPT_COUNT=1

while [[ (!$SUCCESS) && ATTEMPT_COUNT -le MAX_RETRIES ]];
do
   sleep $VPN_RETRY_TIME
   nmcli con up $VPN_NAME
   SUCCESS=($? = 0)
   ATTEMPT_COUNT=$((ATTEMPT_COUNT+1))
done

# Restart php 7 container
docker restart laradock-php-fpm-1
docker restart laradock-php-fpm-8-1