#!/bin/ash

C2_SERVER_ADDR="https://example.com/simple-c2.php"

cd "$(dirname "$0")"

LAST_HASH=`cat last-hash.txt 2>/dev/null`
C2_ORDER=`curl --silent $C2_SERVER_ADDR | xargs`

C2_CMD=`echo $C2_ORDER | cut -d '.' -f1`
C2_HASH=`echo $C2_ORDER | cut -d '.' -f2`

if [ "$C2_HASH" != "$LAST_HASH" ]; then
  echo $C2_HASH > last-hash.txt

  [ -z "$C2_CMD" ] && echo "Empty command. Nothing to do." && exit 0

  if [ "$C2_CMD" == "reboot" ]; then
    echo "Received reboot command from C2. Rebooting after 10s..."
    logger -t "Arouter C2" "Received reboot command from C2. Rebooting after 10s..."
    sleep 10 && touch /etc/banner && reboot
  else
    echo "Received unfamiliar command from C2. Ignored!"
    logger -t "Arouter C2" "Received unfamiliar command from C2. Ignored."
  fi
else
  echo "Same as last hash. Ignored."
fi