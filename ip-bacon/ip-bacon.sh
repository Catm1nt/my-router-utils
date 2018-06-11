#!/bin/ash

DO_API_TOKEN="abcde1234567890"
DOMAIN="example.com"
SUBDOMAIN="router"
RECORD_ID="123456789"
IP_GET_URL="https://canhazip.com/"

cd "$(dirname "$0")"

OUR_IP=`curl --silent $IP_GET_URL | xargs`
STORED_IP=`cat stored-ip.txt 2>/dev/null`

if [ "$OUR_IP" != "$STORED_IP" ]; then
  curl -s -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $DO_API_TOKEN" -d '{"name":"'${SUBDOMAIN}'","data":"'${OUR_IP}'"}' "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID" > /dev/null
  echo $OUR_IP > stored-ip.txt
  echo "Our new IP is '$OUR_IP'. We told DigitalOcean"
  logger -t "IP Bacon" "Our new IP is '$OUR_IP'. We told DigitalOcean"
else
  echo "Our IP '$OUR_IP' hasn't changed. Going back to sleep Zzzz"
  logger -t "IP Bacon" "Our IP '$OUR_IP' hasn't changed. Going back to sleep Zzzz"
fi