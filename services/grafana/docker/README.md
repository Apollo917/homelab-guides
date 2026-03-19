# Grafana – Docker Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide assumes:
    - The reverse proxy network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as Grafana is configured to use it as a reverse
      proxy
    - You have a base directory for all Docker-related files, e.g. `~/docker/<service_name>`

## Setup

1. Create the Grafana root directory
    - `mkdir ~/docker/grafana`
2. Move the contents of the [resources](./resources) directory into the Grafana root directory
3. Remove **.gitkeep** files from the data directory
4. Fill in the empty properties in the [.env](resources/.env) file
    - `UID` — the system user ID under which Grafana will run (`id -u`)
    - `GID` — the system group ID under which Grafana will run (`id -g`)
    - `SERVICE_URL` — the URL at which Grafana is accessible, without protocol
5. Navigate to the Grafana root directory and launch the Grafana service
    - `docker compose up -d`
6. Verify the deployment
    - Check the service is running: `docker ps`
    - Open `https://<SERVICE_URL>` in your browser
