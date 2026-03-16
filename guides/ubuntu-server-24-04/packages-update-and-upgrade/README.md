# Ubuntu Server 24.04 – Packages Update and Upgrade

- `sudo apt-get update`
- `sudo apt-get dist-upgrade`

**Why this combination:**

- `apt-get update` refreshes the package index so the system knows what versions are available — it installs nothing
- `apt-get dist-upgrade` upgrades all packages and, unlike plain `apt-get upgrade`, also handles dependency changes —
  it can install new dependencies or remove obsolete ones to complete the upgrade cleanly

## Materials

- [apt-get upgrade vs apt-get dist-upgrade](https://askubuntu.com/questions/194651/why-use-apt-get-upgrade-instead-of-apt-get-dist-upgrade)
