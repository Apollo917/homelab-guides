# Wake-on-LAN (WoL) Setup

**Wake-on-LAN (WoL)** is a networking standard that allows a machine to be powered on remotely by sending a special
network packet called a "magic packet" to its MAC address. It is useful for homelabs where you want to keep machines
powered off to save energy but still be able to boot them on demand — for example, to wake a NAS or server before
running a backup job, or to access a machine remotely without leaving it running 24/7

> **BIOS/UEFI:** WoL must be enabled in your machine's BIOS/UEFI firmware before the OS-level setup will have any
> effect. Look for a setting named "Wake-on-LAN", "Power On By PCI-E", or similar under the Power or Network section

## Setup

1. Get the name of your NIC
    - `ip addr show`
2. Check WoL status and what WoL options your NIC supports
    - `sudo ethtool <NIC_NAME> | grep "Wake-on"`
        - The output shows two lines — `Supports Wake-on` lists the available modes, `Wake-on` shows the current mode
        - `g` means magic packet (what you want); `d` means disabled
        - If `g` is not listed under `Supports Wake-on`, the NIC does not support WoL and the steps below will not work
3. Edit [wol.service](wol.service) — replace `enp1s0` on the `ExecStart` line with your NIC name from step 1
4. Create a new service to automatically enable WoL on system startup
    - Copy [wol.service](wol.service) into `/etc/systemd/system/` directory
5. Reload systemctl so it will pick up the newly created service
    - `sudo systemctl daemon-reload`
6. Start and enable the service
    - `sudo systemctl enable wol.service`
    - `sudo systemctl start wol`

## Sending a Magic Packet

Once the target machine is configured, you can wake it from another device on the same network using `wakeonlan`:

- The MAC address of the target NIC can be found with `ip addr show` on the target machine

```bash
# Install
sudo apt install wakeonlan

# Wake the machine (replace with the target's MAC address)
wakeonlan <MAC_ADDRESS>
```

> Alternatively, smartphone apps can send magic packets — search for "Wake-on-LAN" in your platform's app store

## Materials

### YouTube

- [Turn on your Server from anywhere](https://youtu.be/6QhA_mKHINc?si=oMwNSYFdgsK-An7S)
