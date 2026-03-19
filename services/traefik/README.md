# Traefik

Traefik is a modern reverse proxy and load balancer designed for cloud-native applications and containerized
environments.

It automatically routes incoming HTTP/HTTPS requests to the appropriate backend services based on configuration rules
such as domain names, paths, or ports. Traefik integrates well with platforms like Docker and Kubernetes, allowing it
to dynamically discover services and update routing without manual reconfiguration.

In addition, Traefik can handle TLS/SSL termination, automatically obtain and renew certificates (for example from
Let’s Encrypt), and provide features such as load balancing, middleware support, and request monitoring.

## Setup

- [Docker](./docker/README.md)
- [Docker Swarm](./docker-swarm/README.md)

## Materials

- [Docker Hub](https://hub.docker.com/_/traefik)

### Docs

- [Traefik](https://traefik.io/)
- [Traefik docs](https://doc.traefik.io/traefik/)

### Articles

- [Traefik Portainer SSL](https://github.com/techno-tim/techno-tim.github.io/tree/master/reference_files/traefik-portainer-ssl/traefik)

### YouTube

- [Put Wildcard Certificates and SSL on EVERYTHING - Traefik Tutorial](https://youtu.be/liV3c9m_OX8)
- [Is this the BEST Reverse Proxy for Docker? // Traefik Tutorial](https://youtu.be/wLrmmh1eI94)
- [How to Install and Setup Traefik with Cloudflare Using Your Own Domain](https://youtu.be/b83S_N1kkJM)
