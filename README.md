The script you provided is an automated installation tool that helps users set up a Windows Server or Windows version on a QEMU virtual machine. Based on the script, the README can be updated to reflect the process accurately. Here's an updated version of the README:

---

## **README: Automated Windows Server Installation Script**

### **Introduction**
This script automates the installation of Windows Server or Windows desktop versions on a QEMU virtual machine. It supports various Windows versions and automatically downloads the necessary ISO files, creates the virtual machine's disk image, and sets up QEMU for running the virtual machine.

### **Supported Windows Versions:**
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022
- Windows 10
- Windows 11
- Windows 10 22H2

### **Installation Instructions**

#### **1. Download the Installer Script**

To begin, download the installer script to your Linux system:

```bash
wget https://raw.githubusercontent.com/sh13y/windows-server-qemu-installer/main/windows-server-auto-installer.sh
```

#### **2. Grant Execution Permission to the Script**

After downloading, grant execution permission to the script:

```bash
chmod +x windows-server-auto-installer.sh
```

#### **3. Run the Script**

Run the script to start the installation process:

```bash
./windows-server-auto-installer.sh
```

The script will perform the following tasks:

1. **Update System Packages**: It will update your system’s package list and upgrade any outdated packages.
2. **Install QEMU and Required Utilities**: The script installs QEMU, including all necessary components like `qemu-system-x86`, `qemu-utils`, and `qemu-kvm`.
3. **Display Menu for Version Selection**: It prompts you to choose which version of Windows you wish to install.

#### **4. Choose Windows Version**

When prompted, select the desired Windows version by entering the corresponding number:

```
1. Windows Server 2016
2. Windows Server 2019
3. Windows Server 2022
4. Windows 10
5. Windows 11
6. Windows 10 21H2
```

For example, entering `1` will set up Windows Server 2016.

#### **5. Script Execution**

Once you make your selection, the script will:
- Download the necessary Windows ISO and Virtio driver ISO.
- Create a raw image file for the virtual machine with a size of 40GB.
- Download the corresponding Windows ISO based on your choice.

#### **6. Launch QEMU**

After the ISO files and image are downloaded, you can launch QEMU using the generated disk image and the Windows ISO:

```bash
qemu-system-x86_64 \
-m 4G \
-cpu host \
-enable-kvm \
-boot order=d \
-drive file=[iso_file_name].iso,media=cdrom \
-drive file=[img_file_name].img,format=raw,if=virtio \
-drive file=virtio-win.iso,media=cdrom \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-vnc :0
```

Replace `[img_file]` with the image file name (e.g., `windows2016.img`) and `[iso_file]` with the corresponding ISO file name (e.g., `windows2016.iso`).

### **Additional Configuration After Installation**

After Windows is installed and running, you may need to:

1. Enable **Remote Desktop** in Windows Server settings.
2. Disable **CTRL+ALT+DEL** in the Local Security Policy.
3. Set Windows Server to **never sleep**.
4. Disable the "Security Prevent Logon Blank Password" in Local Security (if your Windows server does not use a password).

### **7. Compress the Windows Server Image (Optional)**

Once configuration is complete, you can compress the Windows Server disk image for easier storage or transfer. Replace `xxxx` with the version of Windows you selected:

```bash
dd if=windowsxxxx.img | gzip -c > windowsxxxx.gz
```

### **8. Install Apache and Serve the Image File (Optional)**

You can install Apache to serve the compressed image file over the web. Install Apache:

```bash
apt install apache2
```

Allow Apache through the firewall:

```bash
sudo ufw allow 'Apache'
```

Move the compressed Windows Server file to the Apache web directory:

```bash
cp windowsxxxx.gz /var/www/html/
```

Access the file through your server’s IP address:

```arduino
http://[IP_Droplet]/windowsxxxx.gz
```

### **Running Windows Server on a New Droplet**

To run the compressed Windows Server image on a new droplet, use the following command:

```bash
wget -O- --no-check-certificate LINK | gunzip | dd of=/dev/vda
```

Replace `LINK` with the actual URL of the compressed image file.

---

### **Important Notes:**
- **Replace `xxxx`** with the correct Windows version in the commands.
- Ensure to use the correct **download link** (`LINK`) when restoring the image on a new droplet.
- The script will automatically handle the download of Windows ISOs and Virtio drivers, so you don’t need to manually search for them.

