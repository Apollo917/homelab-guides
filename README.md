# Homelab Guides

A collection of practical homelab setup guides for self-hosted services, operating systems, and system-level tools.

This repository contains processed materials based on video tutorials and articles, organized into written guides that
are easier to follow, reuse, and reference later.

⚠️ **Repository guides are based on my own learning and experience while building and maintaining a homelab. I
am not an expert, so some guides may contain mistakes, imperfections, or better approaches than the ones documented
here**

💡 **It is recommended to review all service files before starting up a service, as they may contain useful
comments on configuration parameters and other details**

## Repository structure

- [Guides](./guides/README.md)
    - Ubuntu Server 24.04
        - [Packages Update and Upgrade](./guides/ubuntu-server-24-04/packages-update-and-upgrade)
        - [QEMU Guest Agent Installation](./guides/ubuntu-server-24-04/packages-update-and-upgrade)
        - [Static IP Address Configuration](./guides/ubuntu-server-24-04/static-ip-address-configuration)
        - [Basic Security Setup](./guides/ubuntu-server-24-04/basic-security-setup)
        - [Node Exporter Installation](./guides/ubuntu-server-24-04/node-exporter-installation)
        - [Docker Installation](./guides/ubuntu-server-24-04/docker-installation)
    - TrueNAS
        - [TLS Certificates Setup](./guides/truenas/tls-certificates-setup)
    - Other
        - [OpenSSH Configuration](./guides/other/openssh-configuration)
- [Services setup guides](./services/README.md)
    - [Traefik](./services/traefik/README.md)
    - [Prometheus](./services/prometheus/README.md)

## Purpose

The goal of this repository is to keep homelab knowledge in one place in a structured and reusable format.

Instead of jumping between videos, articles, bookmarks, and scattered notes, this repo aims to provide:

- Clear step-by-step documentation
- Reference materials for repeatable setups
- Additional resources related to each guide
- A central knowledge base for self-hosting and homelab experiments

## What this repository includes

- Setup guides for various homelab services
- Guides for both containerized and non-containerized deployments
- Notes and instructions for operating systems and OS-level services
- Supporting resources used while preparing the guides

## How to use this repository

1. Browse the available guides by topic or service
2. Follow the documented steps for your environment
3. Check linked or referenced resources where provided
4. Adapt configurations to your own homelab needs

## Notes

- Guides may cover multiple installation approaches depending on the service
- Some setups may use containers, while others may run directly on the host system
- Resource links and references are included when they help explain or support the guide
