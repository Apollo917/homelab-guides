# Ubuntu Server 24.04 – Docker Installation

## Installation

The preferred way to install Docker on Ubuntu is via the **official Docker apt repository**. Follow
the [Install Docker using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
guide from Docker's official documentation

**Why this approach:**

- **Up-to-date packages** — Docker's apt repo always ships the latest stable releases. Ubuntu's default repo lags behind
  and often provides an outdated version (e.g., Ubuntu 24.04 ships Docker 24.x while Docker's repo provides 27.x+)
- **Seamless upgrades** — once the repo is configured, `apt upgrade` keeps Docker up to date like any other system
  package, with no manual reinstallation needed
- **Official support** — packages are built, signed, and maintained by Docker Inc., ensuring they match the official
  documentation and release notes
- **Timely security patches** — critical CVEs are patched in Docker's repo before they reach distro mirrors
- **Avoids the convenience script in production** — the `get.docker.com` script is fine for testing but not recommended
  for production servers as it offers less control and is harder to audit

## Post-Installation

After installing Docker, follow
the [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/).
These steps are not required for Docker to work, but are essential for a usable and stable setup:

- **Running Docker without `sudo`** — by default only `root` can run Docker commands. Adding your user to the `docker`
  group removes that friction
- **Starting Docker on boot** — without this, Docker won't start after a reboot and your containers won't come back up
  automatically

## Materials

### Docs

- [Docker](https://www.docker.com)
- [Docker docs](https://www.docker.com/get-started/)

### Articles

- [Install Docker using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
- [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/)