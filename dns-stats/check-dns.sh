#!/bin/ash

measure_ping(){
  local IP=$1
  local ping_time=$(ping -q $IP -c 5 | tail -1 | cut -d' ' -f4 | cut -d'/' -f2)
  echo "$ping_time"
}

measure_resolve(){
  local IP=$1
  local all_resolve_times=0
  for i in 1 2 3 4 5 ; do
    local random_domain=$(shuf -n 1 top-20k.txt)
    local resolve_time=$(dig +time=1 -t A $random_domain @$IP | grep msec | cut -d' ' -f4)
    local all_resolve_times=$(($all_resolve_times + $resolve_time))
  done
  local average_resolve_time=$(echo "scale=3;$all_resolve_times / 5" | bc)
  echo "$average_resolve_time"
}

cd "$(dirname "$0")"

start_time=$(date +%s)
LINE="$start_time,"
SERVERS='8.8.8.8 9.9.9.9 208.67.222.222 1.1.1.1'

for server in $SERVERS ; do
  ping_latency=$(measure_ping $server)
  resolve_latency=$(measure_resolve $server)
  LINE="$LINE$ping_latency,$resolve_latency,"
done

LINE=${LINE%?}
echo $LINE >> dns_stats.csv
