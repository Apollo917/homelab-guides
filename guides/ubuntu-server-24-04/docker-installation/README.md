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

## Docker Swarm Initialization

**Docker Swarm** is Docker's built-in container orchestration mode. It turns a group of Docker hosts into a single
cluster — called a **swarm** — with one or more **manager** nodes that schedule workloads and **worker** nodes that run
them. Services defined in a Compose file are distributed across the swarm, and Swarm handles restarts, scaling, and
rolling updates automatically

Key concepts:

- **Manager node** — controls the swarm, schedules services, and maintains cluster state; the node you run
  `docker stack deploy` from
- **Worker node** — joins the swarm and runs assigned containers; has no scheduling authority
- **Service** — the Swarm equivalent of a Compose service; defines the image, replicas, and placement constraints
- **Stack** — a group of related services deployed together from a Compose file via `docker stack deploy`

### Swarm Initialization

1. Initialize the swarm on the manager node
    - `docker swarm init --advertise-addr <HOST_IP>`
    - This outputs a `docker swarm join` command with a token — save it to add worker nodes later
2. Verify the swarm is active
    - `docker node ls`
3. (Optional) Retrieve the join token later if needed
    - `docker swarm join-token worker`

> **Note:** a single-node swarm (manager only) is valid and useful — you still get Swarm-only features like
> `docker stack deploy`, configs, and secrets without needing multiple hosts

### Tips

#### Labeling nodes

Labels are key/value metadata attached to a node, used to control where services are scheduled
via placement constraints in your Compose file

- Add a label to a node
    - `docker node update --label-add <KEY>=<VALUE> <NODE_NAME>`
- View labels on a node
    - `docker node inspect <NODE_NAME> --format '{{ .Spec.Labels }}'`

## Materials

### Docs

- [Docker](https://www.docker.com)
- [Docker docs](https://www.docker.com/get-started/)

### Articles

- [Install Docker using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
- [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/)