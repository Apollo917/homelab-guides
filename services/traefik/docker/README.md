# Traefik Docker Setup

1. Issue a Cloudflare API token for your domain with the following permissions
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
    - Traefik Docker image version, etc.
8. Generate and set password for Basic Auth
    - `htpasswd -nB <username>`
    - Replace `<LOGIN_PASSWORD>` with the generated value in
      the [default dynamic config](./resources/configs/dynamic/_default.yml) file
9. Set the correct permissions for **acme.json**
    - `chmod 600 ~/docker/traefik/certs/acme.json`
10. Navigate to the Traefik root Docker directory and launch Traefik
    - `docker compouse up -d`
11. Check Traefik Docker service logs
    - `docker logs traefik`
12. If the Traefik Docker service logs contain no errors, switch Let’s Encrypt from **staging** to **production** in
    the [traefik.yml](./resources/configs/traefik.yml) file by commenting out the **staging** property and uncommenting
    the **production** property
13. Restart Traefik Docker service
    - `docker restart traefik`