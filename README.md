
<div align="center">

# Paper-Pusher
**A Bash script for sending spam to WiFi connected printers over LAN.**

![gif](https://github.com/user-attachments/assets/792e6522-ade0-4bfb-bed7-25e3a3336714)

</div>

Paper-Pusher uses `Nmap` to scan the LAN subnet and find paper printers with port 9100 open and sends spam (in an infinite loop) to be printed via RAW printing with `Netcat`. You can enter text to be printed or leave blank to dispense blank paper only. The script assumes that the subnet netmask is: `255.255.255.0`.

**Dependencies:**
  - `Linux`
  - `Nmap`
  - `Netcat`

### How to use:
  1. `git clone https://github.com/OSINTI4L/Paper-Pusher`
  2. `cd Paper-Pusher`
  3. `chmod +x PaperPusher.sh`
  4. Connect to WiFi LAN that target printer is on.
  5. Run: `./PaperPusher.sh`

Paper-Pusher is automated, follow the prompts.

If you have multiple printers on the LAN it might break the script. I don't have multiple printers, so I can't test it, *shrugs*.

Shout out to SpuriousIndices aka the Printer God, for teaching me how to mess with printers.
