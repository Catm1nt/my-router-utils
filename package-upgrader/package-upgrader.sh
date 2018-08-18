#!/bin/ash
# From https://github.com/danielvijge

echo "Updating package list..."
opkg update > /dev/null

if [ `opkg list-upgradable | cut -d " " -f1 | grep -v "kmod-" | wc -l` -gt 0 ]; then
  echo "Available updates:"
  opkg list-upgradable | grep -v "kmod-"
  echo ""

  valid=0
  while [ $valid == 0 ]
  do
    read -n1 -s -p "Upgrade all available packages? [Y/n]" choice
    case $choice in
      y|Y|"" )
        valid=1
        echo ""
        echo "Upgrading all packages..."
        opkg list-upgradable | cut -d " " -f1 | grep -v "kmod-" | xargs -r opkg upgrade
        ;;
      n|N)
        valid=1
        echo ""
        echo "Upgrade cancelled"
        ;;
      *)
        echo ""
        echo "Unknown input"
        ;;
    esac
  done
else
  echo "No updates available"
fi