# Traefik Docker Swarm Setup

1. Issue a Cloudflare API token for your domain with the following permissions
    - **Zone:Read, DNS:Edit**
2. Initialize Docker Swarm if it is not initialized yet
    - `docker swarm init`
3. Create a Docker overlay network for Traefik
    - `docker network create --driver overlay --attachable reverse-proxy`
4. Create all required Docker Swarm secrets
    - `printf "<CLOUDFLARE_DNS_API_TOKEN>" | docker secret create cf_dns_api_token -`
5. Update the `<DOMAIN_NAME>` value in the [compose.yml](./resources/compose.yml) file
6. Update the `<CLOUDFLARE_ACCOUNT_EMAIL_ADDRESS>` value in the [traefik.yml](./resources/configs/traefik.yml) file
7. Create the Traefik root directory
    - `mkdir traefik`
8. Move the contents of the [resources](./resources) directory into the Traefik root directory
9. Adjust the Traefik configuration if needed
    - Traefik Docker image version, [traefik configs](./resources/configs), etc.
10. Generate and set password for Basic Auth
    - `htpasswd -nB <username>`
    - Replace `<LOGIN_PASSWORD>` with the generated value in
      the [default dynamic config](./resources/configs/dynamic/_default.yml) file
11. Set the correct permissions for **acme.json**
    - `chmod 600 ~/docker/traefik/certs/acme.json`
12. Navigate to the Traefik root Docker directory and launch Traefik service
    - `docker stack deploy -c compose.yml traefik`
13. Check Traefik Docker service logs
    - `docker service logs traefik_traefik`
14. If the Traefik Docker service logs contain no errors, switch Let’s Encrypt from **staging** to **production** in
    the [traefik.yml](./resources/configs/traefik.yml) file by commenting out the **staging** property and uncommenting
    the **production** property
15. Restart Traefik Docker service
    - `docker service update --force traefik_traefik`