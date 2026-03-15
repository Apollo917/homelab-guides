# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

A collection of practical homelab setup guides compiled from open-source materials (articles, videos, documentation).
Guides cover containerized service setups (Docker / Docker Swarm) and will expand to OS-level services, Proxmox setup,
and other topics.

## Conventions

- Config file comments are intentional — they explain parameters and warn about things that change over time (e.g.,
  Cloudflare IP ranges). Preserve them.

## Review Checklist

When adding or editing any file, check for:

### Security / Privacy

- **No real domain names** — use `{{ env "DOMAIN_NAME" }}` in config files or `<DOMAIN_NAME>` as a placeholder in `.env`
  templates and prose.
- **No API tokens, passwords, or secrets** — `.env` files must be templates with empty values or `<PLACEHOLDER>` style
  markers.
- **No public IP addresses** — private RFC 1918 addresses (`10.x.x.x`, `172.16–31.x.x`, `192.168.x.x`) are allowed,
  both as CIDR ranges and specific host addresses. Public (routable) IP addresses must never appear and should be
  replaced with a placeholder (e.g., `<SERVER_IP>`).
- `acme.json` files must remain empty (0 bytes) — they are generated at runtime and must never be committed with
  content.

### Documentation Quality

- **Grammar and spelling** — guides are written in English; fix typos and grammatical errors.
- **Clarity** — steps should be unambiguous and self-contained. If a step requires prior knowledge or a prerequisite,
  call it out explicitly.
- **Placeholder consistency** — use `<SCREAMING_SNAKE_CASE>` for all user-supplied values in prose and `.env` templates.
- **Numbered steps** — setup guides use ordered lists; keep steps atomic (one action per step).
- **Internal links** — verify that all Markdown links pointing to other files or directories within the repo resolve to
  paths that actually exist.
