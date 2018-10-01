#!/bin/ash

sed -ne '/^Package:[[:blank:]]*/ {
	s///
	h
}
/user installed/ {
	g
	p
}' /usr/lib/opkg/status > /etc/config/packages.list

