#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 1124h2"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10
        img_file="windows10.img"
        iso_link="http://134.199.163.87/WIN10.iso"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="http://134.199.163.87/WIN11.iso"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 1021h2
        img_file="windows1124h2.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win11_24H2_English_x64.iso?t=59f92b8b-1a8f-4881-94c9-4da804ff6558&P1=1742889359&P2=601&P3=2&P4=nPfSvOKA5c8N%2flqLquFQ5I4M%2fl19K96WuIk%2fSoHBBR7g3kJh7PNch8riDWiVM1dqecCh7xCMLlQmNCA98TfC5M4MoYaDKrdRlch8Tqz9R3L2Lz6Gp5XkqOA4c3DCtURNmkq4dk4lpFS0X54yzWlxK1VmteiI9Vu4Egkj77f5yqBI8mY6w3Fiw7FgCrKg28MwVg1wFWJ9Euz36ULwIMq7qxqesmi44vcWVcVlD40OOqU4APmZShhiSxokfaYP9G4wMg3h31FRnk4c2uW4i3he4NU%2fcMM%2bhHPXX6GBjvd4UI29ezeffa5VBUv5DXF%2fBKP9MRpizPiUESYUme5OpSIcuA%3d%3d"
        iso_file="windows1124h2.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
