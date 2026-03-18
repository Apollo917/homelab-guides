# Proxmox – VM Template Setup

Creating a VM template lets you provision new virtual machines in seconds rather than going through a full OS
installation each time. Instead of repeating the same setup steps — installing an OS, configuring packages, setting up
SSH — you do it once, convert the result to a template, and clone from it whenever you need a new VM. Templates also
make it easy to standardize your VMs: every clone starts from the same known-good baseline, reducing configuration drift
across your homelab.

> **Note:** The steps below are a high-level cheatsheet intended for users who have already set up a VM template before.
> If this is your first time, the YouTube videos in the [Materials](#materials) section provide a more detailed
> walkthrough

## Setup

1. Create a VM
    - On **OS** tab select **Do not use any media**
    - On **Disks** tab remove default disk and leave it empty
2. Go to the VM hardware tab
    - Add **CloudInit Drive**
    - In **Cloud-Init** tab set default properties
    - Press **Regenerate Image**
3. Go to the Proxmox node terminal
    - Log in as root or sudo user
    - Download cloud image
        - `wget https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img`
    - Rename the image to give it a **.qcow2** extension
        - `mv ubuntu-24.04-server-cloudimg-amd64.img ubuntu-server-2404.qcow2`
    - Resize the image to the preferred size
        - `qemu-img resize ubuntu-server-2404.qcow2 5G`
    - Import the image as the disk to the VM
        - `qm importdisk <VM_ID> ubuntu-server-2404.qcow2 <STORAGE>`
        - `<STORAGE>` — the storage ID to import the disk into (e.g. `local-lvm`, `local-zfs`); check available storages
          in **Datacenter → Storage**
4. Go to the VM Hardware tab
    - Add unused disk
    - Enable **Discard**
    - Enable **SSD emulation**
    - Remove **CD/DVD Drive** (optional)
5. Go to the VM Options tab
    - Select **Boot Order** property
    - Enable imported disk/image
    - Place it on the first position
6. Convert to Template
    - Open VM context menu
    - Press **Convert to template**

## Materials

### YouTube

- [How to build an Ubuntu 22.04 Template](https://youtu.be/MJgIm03Jxdo?si=GXgcrWV49EuSVj2s)
- [Linux VM Templates in Proxmox on EASY MODE using Prebuilt Cloud Init Images](https://youtu.be/E7rv08ttv8k?si=w21BZJqTYyIBrHEv)

### Resources

- [Ubuntu Downloads](https://cloud-images.ubuntu.com/releases)