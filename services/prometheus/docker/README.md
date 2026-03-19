# Prometheus – Docker Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide assumes:
    - The reverse proxy network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as Prometheus is configured to use it as a reverse
      proxy
    - You own the base directory for all Docker-related files. It could be e.g. `~/docker/<service_name>`

## Setup

1. Create the Prometheus root directory
    - `mkdir ~/docker/prometheus`
2. Move the contents of the [resources](./resources) directory into the Prometheus root directory
3. Remove **.gitkeep** file from the **data** directory
4. Set [.env](./resources/.env) file property values
5. Adjust the Prometheus configuration if needed
    - Prometheus image version, [prometheus.yml](./resources/config/prometheus.yml) scrape config, etc.
    - **Note:** the current [prometheus.yml](./resources/config/prometheus.yml) config uses
      the [DNS discovery approach](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#dns_sd_config);
      adjust it to your needs with
      other [service discovery methods](https://prometheus.io/docs/prometheus/latest/configuration/configuration/)
      configs
6. Navigate to the Prometheus root directory and launch the Prometheus service
    - `docker compose up -d`
7. Verify the deployment
    - Check the service is running: `docker ps`
    - Open `https://prometheus.<DOMAIN_NAME>` in your browser
