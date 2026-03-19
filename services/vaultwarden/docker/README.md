# Vaultwarden – Docker Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide assumes:
    - The reverse proxy network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as Vaultwarden is configured to use it as a reverse
      proxy
    - You have a base directory for all Docker-related files, e.g. `~/docker/<service_name>`

## Setup

1. Create the Vaultwarden root directory
    - `mkdir ~/docker/vaultwarden`
2. Move the contents of the [resources](./resources) directory into the Vaultwarden root directory
3. Remove **.gitkeep** files from the data child directories
4. Fill in the empty properties in the [.env](resources/.env) file
    - `VAULTWARDEN_SERVICE_URL` — the URL at which Vaultwarden is accessible
    - `DOMAIN` — the public-facing URL of the Vaultwarden instance
    - `ORG_CREATION_USERS` — comma-separated list of emails allowed to create organizations
    - `INVITATION_ORG_NAME` — organization name shown in invitation emails
5. Adjust the Vaultwarden configuration if needed
6. Navigate to the Vaultwarden root directory and launch the Vaultwarden service
    - `docker compose up -d`
7. Verify the deployment
    - Check the service is running: `docker ps`
    - Open `https://<VAULTWARDEN_SERVICE_URL>` in your browser
