# Traefik – Docker Swarm Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide covers a single-node Docker Swarm deployment
- This guide assumes:
    - You are already running Docker Swarm, have a node ready to deploy the Traefik service on, and that node is
      already labeled
    - You own the base directory for all Docker-related files. It could be e.g. `~/docker/<service_name>`
    - **htpasswd** is installed

## Setup

1. Issue a [Cloudflare API token](https://dash.cloudflare.com/profile/api-tokens) for your domain with the following
   permissions
    - **Zone:Read, DNS:Edit**
2. Initialize Docker Swarm if it is not initialized yet
    - `docker swarm init`
3. Create a Docker overlay network for Traefik
    - `docker network create --driver overlay --attachable reverse-proxy`
4. Create all required Docker Swarm secrets
    - `printf "<CLOUDFLARE_DNS_API_TOKEN>" | docker secret create cf_dns_api_token -`
5. Create the Traefik root directory
    - `mkdir ~/docker/traefik`
6. Move the contents of the [resources](./resources) directory into the Traefik root directory
7. Set [compose.yml](./resources/compose.yml) file property values
    - **<DOMAIN_NAME>**: the base domain name (e.g. example.com) — used to route traffic and issue TLS certificates for
      services under this domain. Traefik will be accessible at traefik.<DOMAIN_NAME>
    - **<HOST_NAME>**: the host name of your Swarm node
8. Update the `<CLOUDFLARE_ACCOUNT_EMAIL_ADDRESS>` value in the [traefik.yml](./resources/configs/traefik.yml) file
9. Adjust the Traefik configuration if needed
    - Traefik Docker image version
    - [Traefik static config](./resources/configs/traefik.yml)
    - [Traefik dynamic configs](./resources/configs/dynamic)
    - **Note:** Cloudflare IP ranges in [_default.yml](./resources/configs/dynamic/_default.yml) may change —
      check https://www.cloudflare.com/ips/ periodically
    - etc.
10. Generate and set a password for Basic Auth
    - `htpasswd -nB <USERNAME>`
    - Replace `<LOGIN_PASSWORD>` with the generated value in
      the [default dynamic config](./resources/configs/dynamic/_default.yml) file
11. Set the correct permissions for **acme.json** (Let's Encrypt requires this file to have restricted permissions —
    Traefik will fail to start without it)
    - `chmod 600 ~/docker/traefik/certs/acme.json`
12. Navigate to the Traefik root Docker directory and launch the Traefik service
    - `docker stack deploy -c compose.yml traefik`
13. Check Traefik Docker service logs
    - `docker service logs traefik_traefik`
14. If the Traefik Docker service logs contain no errors, switch Let’s Encrypt from **staging** to **production** in
    the [traefik.yml](./resources/configs/traefik.yml) file
    - Comment out `caServer: https://acme-staging-v02.api.letsencrypt.org/directory` and uncomment
      `caServer: https://acme-v02.api.letsencrypt.org/directory`
15. Restart the Traefik Docker service
    - `docker service update --force traefik_traefik`
16. Verify the deployment
    - Check the service is running: `docker service ls`
    - Open `https://traefik.<DOMAIN_NAME>` in your browser