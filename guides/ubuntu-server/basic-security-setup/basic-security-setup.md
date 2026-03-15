# Ubuntu Server Basic Security Setup

> This guide covers basic security hardening steps that provide a reasonable baseline for a homelab Ubuntu server.
> It is not exhaustive — additional measures may be required depending on your threat model and exposure.

## 1. System updates

- Update the system
    - `sudo apt update && sudo apt upgrade`

## 2. Create a non-root sudo user

1. Create a new user
    - `sudo adduser <USERNAME>`
2. Grant sudo privileges
    - `sudo usermod -aG sudo <USERNAME>`
3. Log out and log back in as the new user, then verify sudo access
    - `sudo whoami` (should return **root**)

## 3. Set up an SSH key

1. Generate a new SSH key
    - `ssh-keygen`
2. Deploy the newly created public key to a server
    - `ssh-copy-id -i <PATH_TO_SSH_KEY_PUB_FILE> <USERNAME>@<REMOTE_HOST>`

## 4. Disable SSH root and password login

1. Open the SSH service config file
    - `sudo nano /etc/ssh/sshd_config`
2. Set `PasswordAuthentication` value to **no**
    - Disables login with a password; only SSH key authentication will be accepted
3. Set `PermitRootLogin` value to **no**
    - Prevents the root user from logging in directly over SSH
4. Set `KbdInteractiveAuthentication` value to **no**
    - Disables keyboard-interactive authentication (e.g. PAM-based password prompts)
5. Set `PubkeyAuthentication` value to **yes**
    - Explicitly enables SSH public key authentication
6. Check all included config files under `/etc/ssh/sshd_config.d/` — they may override the settings above
7. Reboot the system to apply changes
    - `sudo reboot`

## 5. Configure the firewall (UFW)

> ⚠️ **Docker bypass warning:** Docker writes its own `iptables` rules directly, bypassing UFW entirely. Any port
> published by a Docker container (via `ports:` in Compose) will be publicly accessible regardless of UFW rules.
> UFW remains useful for protecting non-containerized services (e.g. SSH, Fail2ban targets), but should not be
> relied upon to restrict Docker container traffic.

1. Allow SSH connections before enabling the firewall
    - `sudo ufw allow ssh`
2. Enable UFW
    - `sudo ufw enable`
3. Verify the firewall status
    - `sudo ufw status`

## 6. Install Fail2ban

**Fail2ban** monitors log files and temporarily bans IPs that show signs of brute-force attempts.

> ⚠️ The `fail2ban` package in Ubuntu 24.04’s apt repos (v1.0.2) crashes on startup due to
> `asynchat` being removed in Python 3.12. Install v1.1.0 or later directly from the
> [Fail2ban GitHub releases page](https://github.com/fail2ban/fail2ban/releases) instead.

1. Download the latest `.deb` package from
   the [Fail2ban GitHub releases page](https://github.com/fail2ban/fail2ban/releases)
    - `wget https://github.com/fail2ban/fail2ban/releases/download/1.1.0/fail2ban_1.1.0-1.upstream1_all.deb`
2. Install the downloaded package
    - `sudo dpkg -i fail2ban_1.1.0-1.upstream1_all.deb`
3. Remove the downloaded package file
    - `rm fail2ban_1.1.0-1.upstream1_all.deb`
4. Enable and start the service
    - `sudo systemctl enable --now fail2ban`
5. Verify the service is running
    - `sudo systemctl status fail2ban`
6. Copy [jail.local](./jail.local) minimal config file into the host **fail2ban** root dir `/etc/fail2ban`
    - ⚠️ Never edit the default `jail.conf`
    - ⚠️ Edit `ignoreip` in `jail.local` to add your own IP or subnet — otherwise you risk banning yourself
    - **Fail2ban** uses your firewall to block IPs; if you’re using UFW, make sure it’s active
7. Restart Fail2ban to apply changes
    - `sudo systemctl restart fail2ban`
8. Check status
    - `sudo systemctl status fail2ban`
    - `sudo fail2ban-client status`
    - `sudo fail2ban-client status sshd`
    - `sudo fail2ban-client status recidive`

## Materials

### Articles

- [How to Set Up SSH Keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-22-04)