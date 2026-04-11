# IT-TOOLS - Docker Swarm Setup

- Refer to the [Materials](../README.md#materials) section in the parent README for documentation, useful links, and
  troubleshooting resources
- This guide covers a single-node Docker Swarm deployment
- This guide assumes:
    - You are already running Docker Swarm, have a node ready to deploy the IT-TOOLS service on, and that node is
      already labeled
    - The reverse proxy overlay network (**reverse-proxy**) is already created
    - [Traefik](../../traefik/README.md) is already running, as IT-TOOLS is configured to use it as a reverse proxy
    - You own the base directory for all Docker-related files. It could be e.g. `~/docker/<service_name>`

## Setup

1. Create the IT-TOOLS root directory
    - `mkdir ~/docker/it-tools`
2. Move the contents of the [resources](./resources) directory into the IT-TOOLS root directory
3. Set [compose.yml](./resources/compose.yml) file property values
    - **<DOMAIN_NAME>**: the base domain name (e.g. example.com) — IT-TOOLS will be accessible at tools.<DOMAIN_NAME>
    - **<HOST_NAME>**: the host name of your Swarm node
4. Navigate to the IT-TOOLS root directory and launch the IT-TOOLS service
    - `docker stack deploy -c compose.yml tools`
5. Verify the deployment
    - Check the service is running: `docker service ls`
    - Open `https://tools.<DOMAIN_NAME>` in your browser