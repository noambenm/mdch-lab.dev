#!/bin/bash

# Raspberry Pi 5 Setup Script

# Update the Pi
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo rpi-update -y

# Default IP configuration
default_ip="192.168.1.10/24"
default_gw="192.168.1.254"
default_dns="192.168.1.254,1.1.1.1"

# Prompt user for IP details
echo "Press Enter to accept default values."
read -p "Enter static IP address (default: $default_ip): " ip_address
ip_address=${ip_address:-$default_ip}

read -p "Enter Gateway address (default: $default_gw): " gateway
gateway=${gateway:-$default_gw}

read -p "Enter DNS servers, comma-separated (default: $default_dns): " dns_servers
dns_servers=${dns_servers:-$default_dns}

# Set static IP using nmcli
connection=$(nmcli -t -f NAME connection show --active | grep -v '^lo$')
nmcli con mod "$connection" ipv4.addresses "$ip_address"
nmcli con mod "$connection" ipv4.gateway "$gateway"
nmcli con mod "$connection" ipv4.dns "$dns_servers"
nmcli con mod "$connection" ipv4.method manual

echo "Static IP configuration updated (changes will apply after reboot)."

# Prompt to disable wireless and Bluetooth
PS3="Choose an option: "
options=("Disable All (Wi-Fi and Bluetooth)" "Disable Wi-Fi only" "Disable Bluetooth only" "Do not disable anything")
select opt in "${options[@]}"
do
    case $REPLY in
        1)
            echo -e "\n# Disable Wi-Fi\ndtoverlay=disable-wifi" | sudo tee -a /boot/firmware/config.txt
            echo -e "\n# Disable Bluetooth\ndtoverlay=disable-bt" | sudo tee -a /boot/firmware/config.txt
            break
            ;;
        2)
            echo -e "\n# Disable Wi-Fi\ndtoverlay=disable-wifi" | sudo tee -a /boot/firmware/config.txt
            break
            ;;
        3)
            echo -e "\n# Disable Bluetooth\ndtoverlay=disable-bt" | sudo tee -a /boot/firmware/config.txt
            break
            ;;
        4)
            echo "No hardware disabled."
            break
            ;;
        *)
            echo "Invalid option $REPLY. Please choose again."
            ;;
    esac
done

echo "Configuration completed. Please reboot your Raspberry Pi."

# Prompt to reboot
read -p "Would you like to reboot now? (y/n): " reboot_choice
if [[ "$reboot_choice" == [Yy]* ]]; then
    sudo reboot
else
    echo "Please remember to reboot later for changes to take effect."
fi
