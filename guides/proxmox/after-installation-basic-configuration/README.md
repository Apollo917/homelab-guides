# Proxmox – After Installation Basic Configuration

1. Update the time zone
    - Navigate to `Datacenter > <NODE_NAME> > System > Time` and set the desired time zone
    - **Note:** Any time zone can be used, but keeping all systems in UTC is recommended to avoid confusion across logs
      and services
2. Update DNS settings with fallback DNS addresses
    - Navigate to `Datacenter > <NODE_NAME> > System > DNS` and add the desired DNS servers
    - `1.1.1.1`
    - `8.8.8.8`
    - **Note:** Any DNS servers can be used in any preferred order. If a local DNS server is available (e.g., Pi-hole or
      AdGuard Home), it is worth putting it first so all DNS queries are routed through it
3. Use the Proxmox post-install scripts
    - `bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)"`
    - Disable enterprise repos
    - Add no-subscription repos
    - Remove subscription nag
    - Correct package sources
    - Disable HA
    - Disable Corosync for a Proxmox VE Cluster
    - Update Proxmox
    - **Note:** The scripts were originally created by tteck and migrated to the community repository after his passing.
      See [Proxmox VE Helper-Scripts: A Community Legacy](https://github.com/community-scripts/ProxmoxVE) for more
      details
4. Make the default bridge VLAN-aware
    - Navigate to `Datacenter > <NODE_NAME> > System > Network`, select `vmbr0`, click `Edit`, and enable the
      `VLAN aware` option, then click `Apply Configuration` to apply the changes
    - This allows VMs and containers to be assigned to specific VLANs directly from their network settings, enabling
      network segmentation without requiring additional bridges
5. Enable IOMMU
    - **Note:** IOMMU (Input-Output Memory Management Unit) is required for PCIe passthrough, which allows VMs to
      directly access physical hardware such as GPUs, NICs, or storage controllers with near-native performance
    - Update GRUB
        - Execute `nano /etc/default/grub`
        - Append `GRUB_CMDLINE_LINUX_DEFAULT=` with the appropriate parameter for your CPU. Use a space as the
          delimiter between property arguments
            - Intel: `intel_iommu=on`
            - AMD: `amd_iommu=on`
        - Append `GRUB_CMDLINE_LINUX_DEFAULT=` with `iommu=pt` to improve performance for devices not being passed
          through
        - Disable ASPM & power saving
            - Append `GRUB_CMDLINE_LINUX_DEFAULT=` with `pcie_aspm=off`
        - Save changes and execute `update-grub`
    - Update kernel modules
        - Execute `nano /etc/modules`
        - Add the following modules
          ```
            vfio
            vfio_iommu_type1
            vfio_pci
          ```
        - Save changes and execute `update-initramfs -u -k all`
        - Reboot the system
6. Disable specific offloading features in the NIC driver
    - **Note:** Some NICs hang or drop connections during high-throughput transfers (e.g., large file copies over SMB)
      when used in PCIe passthrough. This is caused by TSO (TCP Segmentation Offload) and GSO (Generic Segmentation
      Offload) incompatibilities in the passthrough context. Disabling these features resolves the issue
    - **Note:** Replace `eno1` with the actual interface name of your NIC
    - To resolve this, apply the following fix:
        - Open `/etc/network/interfaces`
        - Add `post-up ethtool -K eno1 tso off gso off` under `iface eno1 inet manual`
            - Use a tab offset before adding
7. Update the root password
    - Execute `passwd`
    - **Note:** This step is optional — skip it if the current password already meets your security requirements
8. Add a non-root admin user and a group for them
    - Avoiding direct use of the root account reduces the risk of accidental or malicious system-wide changes
    - See [How to Add and Delete Users on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-20-04)
    for reference — the commands apply to Proxmox as well
9. Register the new user within Proxmox
    - Proxmox has its own user management system separate from the OS. The OS user created in the previous step needs
      to be registered in Proxmox to be able to log in to the web UI
    - Register a new user
        - Create a user group
        - Add permissions to the created user group
        - Assign the users group to the newly created user
        - See [Proxmox VE - User Management](https://youtu.be/frnILOGmATs?si=Vo6SwBF2jyKmAW4J) for a walkthrough
10. Set OS-level basic security
    - Since Proxmox is Debian-based, the Ubuntu 24.04 security guide is largely applicable here. See
      [Basic Security Setup](../../ubuntu-server-24-04/basic-security-setup/README.md) for reference
    - **Note:** Skip the non-root user creation step from that guide — it is already covered in this guide. The SSH
      key setup is covered in the next step. UFW setup is also not required, as Proxmox has its own firewall
      (covered in step 13)
11. Add an SSH key for the non-root user
    - If no SSH key pair exists yet, generate one on the client machine with `ssh-keygen`
    - Copy the public key to the server with `ssh-copy-id <USERNAME>@<SERVER_IP>`, or manually append it to
      `~/.ssh/authorized_keys` on the server
    - Ensure correct permissions on the server:
        - `chmod 700 ~/.ssh`
        - `chmod 600 ~/.ssh/authorized_keys`
12. Set up SSL Certificates
    - By default, Proxmox uses a self-signed certificate which causes browser warnings. Setting up a trusted SSL
      certificate eliminates these warnings and secures the web UI with proper HTTPS
    - See [Secure Proxmox with LetsEncrypt HTTPS Certificates Validated with Cloudflare DNS](https://youtu.be/2_PhwHOxytM?si=PEtQS6PFgpw01mHJ)
    for a walkthrough
13. Set up the Proxmox Firewall
    - The Proxmox firewall controls traffic to the host and all VMs/containers, allowing you to restrict access to
      management interfaces and services to trusted networks only
    - To enable and configure it, navigate to `Datacenter > Firewall`

## Materials

### Docs

- [Proxmox VE Helper-Scripts: A Community Legacy](https://github.com/community-scripts/ProxmoxVE)
- [Proxmox VE Helper-Scripts](https://community-scripts.github.io/ProxmoxVE/)
- [How to Add and Delete Users on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-20-04)

### YouTube

- [Secure Proxmox with LetsEncrypt HTTPS Certificates Validated with Cloudflare DNS](https://youtu.be/2_PhwHOxytM?si=PEtQS6PFgpw01mHJ)
- [Proxmox VE - User Management](https://youtu.be/frnILOGmATs?si=Vo6SwBF2jyKmAW4J)
- [Proxmox Automation with Proxmox Helper Scripts](https://www.youtube.com/watch?v=kcpu4z5eSEU)
- [5 Things I Would Do On Fresh Install Of ProxMox](https://www.youtube.com/watch?v=xD9Xyt2mdSI)
- [Don’t run Proxmox without these settings!](https://youtu.be/VAJWUZ3sTSI?si=Rpyzrb4JMlqb6lPB)
