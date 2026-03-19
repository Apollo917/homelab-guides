# Prometheus

Prometheus is an open-source monitoring and alerting toolkit that collects and stores metrics as time-series data. It
works by scraping HTTP endpoints exposed by your services at regular intervals, storing the results in its built-in
time-series database (TSDB).

It has become the de facto standard for metrics collection because of its pull-based model (no agent required on
targets), its powerful query language (PromQL), and its native integration with the broader observability ecosystem —
virtually every modern service, from databases to Kubernetes, exposes a `/metrics` endpoint in the Prometheus format. It
pairs naturally with Grafana for dashboards and Alertmanager for notifications.

## Setup

- [Docker](./docker/README.md)
- [Docker Swarm](./docker-swarm/README.md)

## Materials

- [Docker Hub](https://hub.docker.com/r/prom/prometheus)

### Docs

- [Prometheus](https://prometheus.io/)
- [Prometheus docs](https://prometheus.io/docs/introduction/overview/)

### YouTube

- [Server Monitoring // Prometheus and Grafana Tutorial](https://youtu.be/9TJx7QTrTyo)
