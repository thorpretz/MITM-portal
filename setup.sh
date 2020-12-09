#!/bin/bash
@echo off

#replace adapter with target adapter interface
ifconfig adapter down
iwconfig adpater  mode monitor
ifconfig adapter up

hostapd hostapd.config

#add this to hostapd.config
#interface=eth0
#dhcp-range=10.1.1.50,10.1.1.200,12h
#dhcp-host=82:5F:0A:13:5E:B0,10.1.1.100
#dhcp-option=3,10.1.1.1


#creating iptables
sysctl net.ipv4.ip_forward=1
sudo iptables -t nat -A PREROUTING -p tcp --dport 8081 -j DNAT --to-destination 127.0.0.1:8081
sudo iptables -t nat -A PREROUTING -s 192.168.1.0/24 -p tcp --dport 8081 -j DNAT --to-destination 127.0.0.1:8081