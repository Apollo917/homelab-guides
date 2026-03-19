# Ubuntu Server 24.04 – Node-Exporter Service Installation

[Node Exporter](https://github.com/prometheus/node_exporter) is a Prometheus exporter for hardware and OS-level metrics
on Linux hosts. It exposes a `/metrics` HTTP endpoint that Prometheus scrapes to collect data such as CPU usage, memory,
disk I/O, network throughput, and filesystem stats. It is typically run as a systemd service on each host you want to
monitor and paired with Prometheus and Grafana to build dashboards and alerts

## Installation

1. Navigate to the home directory
    - `cd ~`
2. Create a Node Exporter group
    - `sudo groupadd -f node_exporter`
3. Create a Node Exporter system user and add it to the created group
    - `sudo useradd --system --no-create-home -g node_exporter -s /bin/false node_exporter`
4. Download the latest Node Exporter version
   from [Node Exporter releases](https://github.com/prometheus/node_exporter/releases) — pick the latest release and
   replace `<VERSION>` in the commands below with the version number (e.g. `1.9.1`)
    - > **Note:** the commands below use the `linux-amd64` build — if your host is ARM-based (e.g. Raspberry Pi, some
      > cloud VMs), select the matching `linux-arm64` or `linux-armv7` archive from the releases page and adjust the
      > filenames accordingly
    - `wget https://github.com/prometheus/node_exporter/releases/download/v<VERSION>/node_exporter-<VERSION>.linux-amd64.tar.gz`
5. Unpack the downloaded Node Exporter binary and rename the directory
    - `tar -xvf node_exporter-<VERSION>.linux-amd64.tar.gz`
    - `mv node_exporter-<VERSION>.linux-amd64 node_exporter_files`
6. Copy the Node Exporter binary from the **node_exporter_files** folder to **/usr/bin** and change the ownership to the
   Node Exporter user
    - `sudo cp node_exporter_files/node_exporter /usr/bin/`
    - `sudo chown node_exporter:node_exporter /usr/bin/node_exporter`
7. Create [Node Exporter Service](node_exporter.service) — use the service file from the Configs section as a template
    - `sudo nano /usr/lib/systemd/system/node_exporter.service`
    - `sudo chmod 664 /usr/lib/systemd/system/node_exporter.service`
8. Reload systemd, enable and start Node Exporter
    - `sudo systemctl daemon-reload`
    - `sudo systemctl start node_exporter`
    - `sudo systemctl enable node_exporter.service`
    - `sudo systemctl status node_exporter`
9. Verify Node Exporter is running
    - Navigate to `http://<HOST_IP>:9100/metrics`
10. Clean up
    - `rm -rf node_exporter*`

## Materials

### Docs

- [Node exporter GitHub](https://github.com/prometheus/node_exporter)

### Articles

- [MONITORING LINUX HOST METRICS WITH THE NODE EXPORTER](https://prometheus.io/docs/guides/node-exporter/)
- [Prometheus Node Exporter Setup](https://developer.couchbase.com/tutorial-node-exporter-setup)

### Downloads

- [Node Exporter releases](https://github.com/prometheus/node_exporter/releases)
