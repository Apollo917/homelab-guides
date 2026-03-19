# Bind9

**BIND9 (Berkeley Internet Name Domain)** is one of the most widely used open-source DNS servers. It translates
human-readable domain names into IP addresses and vice versa. In a homelab context, running a local BIND9 instance
allows you to define custom DNS records for internal services, enabling name resolution without relying on an
external DNS provider or editing `/etc/hosts` on every machine.

## Setup

1. Update and upgrade packages
    - `sudo apt update && sudo apt upgrade -y`
2. Install Bind9
    - `sudo apt install bind9 bind9utils bind9-doc`
3. Replace the contents of the configuration files in `/etc/bind/` with the contents of the corresponding files from
   the `resources/` directory of this guide
4. Add `include "/etc/bind/named.conf.log";` line into `/etc/bind/named.conf`
5. Create the zones directory and add zone files to `/etc/bind/zones/`
    - `sudo mkdir /etc/bind/zones`
    - Use the files in `resources/zones/` as a reference:
        - `example.com` — forward zone; maps hostnames to IP addresses
        - `homelab.rev` — reverse zone; maps IP addresses back to hostnames
    - **Note:** the `Serial` value in each zone file must be incremented on every change — Bind9 uses it to detect
      updates and will ignore changes if the serial has not increased
6. Edit `/etc/systemd/resolved.conf` to avoid a port 53 conflict — `systemd-resolved` runs a DNS stub listener on
   port 53 by default, which prevents Bind9 from binding to the same port
    - Set `DNS` property value to `127.0.0.1` — redirects system DNS resolution to Bind9
    - Set `DNSStubListener` property value to `no` — disables the stub listener, freeing port 53 for Bind9
7. Restart Network Name Resolution service
    - `sudo systemctl restart systemd-resolved`
8. Restart Bind9 service
    - `sudo systemctl restart bind9`

## Materials

### Docs

- [BIND9](https://www.isc.org/bind/)
- [BIND9 Docs](https://downloads.isc.org/isc/bind9/9.18.16/doc/arm/html/)
- [Configuration Reference](https://bind9.readthedocs.io/en/latest/reference.html)

### Articles

- [BIND9 Docker](https://hub.docker.com/r/ubuntu/bind9)
- [Set Up Local DNS Resolver on Ubuntu 22.04/20.04 with BIND9](https://www.linuxbabe.com/ubuntu/set-up-local-dns-resolver-ubuntu-20-04-bind9)

### YouTube

- [You want a real DNS Server at home? (bind9 + docker)](https://youtu.be/syzwLwE3Xq4)
