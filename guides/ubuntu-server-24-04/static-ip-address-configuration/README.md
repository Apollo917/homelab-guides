# Ubuntu Server 24.04 – Static IP Address Configuration

## Steps

1. Check what network backend is used and note it for step 4
    - `networkctl status`
    - If interfaces appear as `routable` or `configured`, `networkd` is active; if they appear as `unmanaged`,
      `NetworkManager` is likely in use
2. Identify the network interface name to configure
    - `ip link show`
    - Note the interface name (e.g. `eth0`, `enp3s0`, `ens18`)
3. Navigate to the netplan config directory
    - `cd /etc/netplan`
4. Update the netplan config according to the example [config.yml](./config.yml) file
    - Set `renderer` to the network backend identified in step 1
    - Replace `<INTERFACE_NAME>` with the interface name from step 2
    - Replace the IP address, subnet mask, and gateway with your own values
5. Temporarily apply the config to avoid permanent misconfigurations
    - `sudo netplan try`
    - The config reverts automatically after 120 seconds if not confirmed
6. Open a new SSH session and verify the connection to the new IP address works
7. Apply the config permanently
    - `sudo netplan apply`

## Materials

### Articles

- [Setting a Static IP in Ubuntu – Linux IP Address Tutorial](https://www.freecodecamp.org/news/setting-a-static-ip-in-ubuntu-linux-ip-address-tutorial/)

### YouTube

- [How to set Static IP address in Ubuntu Server 24.04](https://youtu.be/9ETDdiWNMP0?si=jfNlkoKsREn5Ux9F)
