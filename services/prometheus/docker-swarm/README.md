# Prometheus – Docker Swarm Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
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
    - `mkdir ~/docker/prometheus`
2. Move the contents of the [resources](./resources) directory into the Prometheus root directory
3. Remove **.gitkeep** file from the **data** directory
4. Set [compose.yml](./resources/compose.yml) file property values
    - **<UID>**: the system user ID under which Prometheus will run — run `id -u` to get the current user's ID
    - **<GID>**: the system group ID under which Prometheus will run — run `id -g` to get the current user's group ID
    - **<DOMAIN_NAME>**: the base domain name (e.g. example.com) — Prometheus will be accessible at prometheus.<
      DOMAIN_NAME>
    - **<HOST_NAME>**: the host name of your Swarm node
    - **storage.tsdb.retention.time**: (optional) how long Prometheus retains time series data (e.g. 15d)
5. Adjust the Prometheus configuration if needed
    - Prometheus image version, [prometheus.yml](./resources/config/prometheus.yml) scrape config, etc.
    - **Note:** the current [prometheus.yml](./resources/config/prometheus.yml) config uses
      the [DNS discovery approach](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#dns_sd_config);
      adjust it to your needs with
      other [service discovery methods](https://prometheus.io/docs/prometheus/latest/configuration/configuration/)
      configs
    - **Tip:** with DNS discovery, you can add multiple A records under a single DNS name (e.g.
      `node-exporter.exporters.example.com` pointing to several hosts) — Prometheus will resolve all of them and scrape
      each one automatically
6. Navigate to the Prometheus root directory and launch the Prometheus service
    - `docker stack deploy -c compose.yml prometheus`
7. Verify the deployment
    - Check the service is running: `docker service ls`
    - Open `https://prometheus.<DOMAIN_NAME>` in your browser
