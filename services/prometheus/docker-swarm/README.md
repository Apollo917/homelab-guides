# Prometheus Docker Swarm Setup

- This guide covers a single-node Docker Swarm deployment
- This guide assumes:
    - You are already running Docker Swarm, have a node ready to deploy the Prometheus service on, and that node is
      already labeled
    - The reverse proxy overlay network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as Prometheus is configured to use it as a reverse
      proxy
    - You own the base directory for all Docker-related files. It could be e.g. `~/docker/<service_name>`

## Setup

1. Create the Prometheus root directory
    - `mkdir prometheus`
2. Move the contents of the [resources](./resources) directory into the Prometheus root directory
3. Remove **.gitkeep** file from the **data** directory
4. Set [compose.yml](./resources/compose.yml) file property values
    - **<UID>**: user id (`id -u`)
    - **<GID>**: user group id (`id -g`)
    - **<DOMAIN_NAME>**: your domain/host name
    - **<NODE_NAME>**: the label assigned to your Swarm node
    - **storage.tsdb.retention.time**: (optional) override the scraped metrics retention period
5. Adjust the Prometheus configuration if needed
    - Prometheus image version, [prometheus.yml](./resources/config/prometheus.yml) scrape config, etc.
    - **Note:** the current [prometheus.yml](./resources/config/prometheus.yml) config uses
      the [DNS discovery approach](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#dns_sd_config);
      adjust it to your needs with
      other [service discovery methods](https://prometheus.io/docs/prometheus/latest/configuration/configuration/)
      configs
6. Navigate to the Prometheus root directory and launch the Prometheus service
    - `docker stack deploy -c compose.yml prometheus`
7. Verify the deployment
    - Check the service is running: `docker service ls`
    - Open `https://prometheus.<DOMAIN_NAME>` in your browser
