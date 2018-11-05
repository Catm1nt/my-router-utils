#!/bin/ash

opkg update
opkg install $(cat /etc/config/packages.list)

