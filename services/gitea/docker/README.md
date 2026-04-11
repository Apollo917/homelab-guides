# Gitea – Docker Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide assumes:
    - The reverse proxy network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as Gitea is configured to use it as a reverse proxy
    - You have a base directory for all Docker-related files, e.g. `~/docker/<service_name>`
    - A PostgreSQL instance is already running and accessible, with a database and user created for Gitea

## Setup

1. Create the Gitea root directory
    - `mkdir ~/docker/gitea`
2. Move the contents of the [resources](./resources) directory into the Gitea root directory
3. Remove **.gitkeep** files from the data directory
4. Fill in the required properties and any optional ones as needed in the [.env](resources/.env) file
5. Navigate to the Gitea root directory and launch the service
    - `docker compose up -d`
6. Verify the deployment
    - Check the service is running: `docker ps`
    - Open `https://gitea.<DOMAIN_NAME>` in your browser
7. Test SSH connectivity
    - Requires an SSH key added to your Gitea account under **Settings → SSH / GPG Keys**
    - `ssh -T git@gitea.<DOMAIN_NAME> -p <SSH_PORT>`
    - A successful response confirms SSH is working:
      `Hi <username>! You've successfully authenticated with the key named <key>, but Gitea does not provide shell access`