# Ubuntu Server 24.04 – QEMU Guest Agent Installation

- The QEMU Guest Agent is a daemon that runs inside a VM and allows the hypervisor (e.g. Proxmox) to communicate with
  the guest OS directly
- It enables graceful shutdown and reboot commands, filesystem freeze/thaw for consistent
  snapshots, and exposes guest info like IP addresses to the host
- It is required whenever the VM is managed by a
  QEMU-based hypervisor and you want reliable snapshot consistency or proper VM lifecycle management

> **Not needed on bare-metal hosts** — if the OS is running directly on physical hardware with no hypervisor, the
> agent has nothing to communicate with and can be skipped

## Installation

1. Update the package index and upgrade installed packages
    - `sudo apt-get update && sudo apt-get dist-upgrade`
2. Install the qemu guest agent package
    - `sudo apt-get install qemu-guest-agent -y`
3. Reboot the system
    - `sudo reboot now`
