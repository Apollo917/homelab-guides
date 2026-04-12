# IT-TOOLS - Docker Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide assumes:
    - The reverse proxy network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as IT-TOOLS is configured to use it as a reverse proxy
    - You own the base directory for all Docker-related files. It could be e.g. `~/docker/<service_name>`

## Setup

1. Create the IT-TOOLS root directory
    - `mkdir ~/docker/it-tools`
2. Move the contents of the [resources](./resources) directory into the IT-TOOLS root directory
3. Fill in the required properties and any optional ones as needed in the [.env](resources/.env) file
4. Navigate to the IT-TOOLS root directory and launch the IT-TOOLS service
    - `docker compose up -d`
5. Verify the deployment
    - Check the service is running: `docker ps`
    - Open `https://tools.<DOMAIN_NAME>` in your browser
