# Proxmox – SSD Disk Passthrough

Disk passthrough allows a VM to access a physical disk directly, bypassing the hypervisor's storage abstraction. This
gives the VM full, low-latency access to the disk and preserves features like SMART data and serial numbers — useful for
NAS setups (e.g., TrueNAS) where the OS needs direct control over storage devices

> This guide covers passthrough of SSD disks

## Configuration

1. Get disk info (model, serial)
    - `lsblk -o +MODEL,SERIAL,WWN`
2. Get persistent disk ID path
    - `ls -l /dev/disk/by-id/`
3. Hot-Plug/Add physical device as new virtual SCSI disk
    - `qm set <VM_ID> -scsi<DISK_NUMBER> /dev/disk/by-id/<DISK_ID>`
4. Tweak VM config at `/etc/pve/qemu-server/<VM_ID>.conf`
    - Disable backup
        - `backup=0`
    - Enable SSD emulation
        - `ssd=1`
    - Add serial number
        - `serial=<DISK_SERIAL>`
5. Reboot VM

**Note:**

- Hot-Unplug/Remove virtual disk
    - `qm unlink <VM_ID> --idlist scsi<DISK_NUMBER>`
- You can pass through a disk partition as well, not only the whole disk

## Materials

### Articles

- [Passthrough Physical Disk to Virtual Machine (VM)](https://pve.proxmox.com/wiki/Passthrough_Physical_Disk_to_Virtual_Machine_(VM))
