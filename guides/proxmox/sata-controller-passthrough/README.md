# Proxmox – SATA Controller Passthrough

Passing through an entire SATA controller to a VM gives that VM direct, low-level access to the drives connected to it.
This is useful when running a NAS OS like TrueNAS inside a VM — it allows the guest to manage drives natively, which is
important for ZFS health monitoring, SMART data, and drive spin-down. It also avoids the overhead and limitations of
virtualized disk access

## Setup

1. Enable IOMMU
    - Covered in step 5 of [After Installation Basic Configuration](../after-installation-basic-configuration/README.md)
2. Pass SATA controller as RAW PCI device
    - Find the SATA controller's PCI address
        - `lspci | grep -i sata`
        - Note the address (e.g. `00:1f.2`)
    - Navigate to `<VM> → Hardware → Add → PCI Device`
        - Select **Raw device** mode
        - Choose the SATA controller by its PCI address
        - Enable **All Functions**
        - Enable **Advanced** (reveals additional settings)
        - Enable **ROM-Bar**
