# Traefik Docker Setup

- This guide assumes:
    - You own the base directory for all Docker-related files. It could be e.g. `~/docker/<service_name>`
    - **htpasswd** is installed

## Setup

1. Issue a [Cloudflare API token](https://dash.cloudflare.com/profile/api-tokens) for your domain with the following
   permissions
    - **Zone:Read, DNS:Edit**
2. Create a Docker network for Traefik
    - `docker network create reverse-proxy`
3. Set the required property values in the [.env](./resources/.env) file
    - `DOMAIN_NAME`
    - `CF_DNS_API_TOKEN`
4. Update the `<CLOUDFLARE_ACCOUNT_EMAIL_ADDRESS>` value in the [traefik.yml](./resources/configs/traefik.yml) file
5. Create the Traefik root directory
    - `mkdir traefik`
6. Move the contents of the [resources](./resources) directory into the Traefik root directory
7. Adjust the Traefik configuration if needed
    - Traefik Docker image version
    - [Traefik static config](./resources/configs/traefik.yml)
    - [Traefik dynamic configs](./resources/configs/dynamic)
    - **Note:** Cloudflare IP ranges in [_default.yml](./resources/configs/dynamic/_default.yml) may change —
      check https://www.cloudflare.com/ips/ periodically
    - etc.
8. Generate and set password for Basic Auth
    - `htpasswd -nB <USERNAME>`
    - Replace `<LOGIN_PASSWORD>` with the generated value in
      the [default dynamic config](./resources/configs/dynamic/_default.yml) file
9. Set the correct permissions for **acme.json** (Let's Encrypt requires this file to have restricted permissions —
   Traefik will fail to start without it)
    - `chmod 600 ~/docker/traefik/certs/acme.json`
10. Navigate to the Traefik root Docker directory and launch Traefik
    - `docker compose up -d`
11. Check Traefik Docker service logs
    - `docker logs traefik`
12. If the Traefik Docker service logs contain no errors, switch Let’s Encrypt from **staging** to **production** in
    the [traefik.yml](./resources/configs/traefik.yml) file
    - Comment out caServer: https://acme-staging-v02.api.letsencrypt.org/directory and uncomment
      caServer: https://acme-v02.api.letsencrypt.org/directory
13. Restart Traefik Docker service
    - `docker restart traefik`
14. Verify the deployment
    - Check the service is running: `docker ps`
    - Open `https://traefik.<DOMAIN_NAME>` in your browser