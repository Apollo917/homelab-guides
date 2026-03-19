# Gitea

**Gitea** is a lightweight, open-source self-hosted Git service. It provides a GitHub-like interface for managing
repositories, issues, pull requests, and user access — all on your own infrastructure. In a homelab context, it is
used to host private Git repositories locally, keeping code and version history off third-party platforms

It also supports automatic repository mirroring, which periodically pulls changes from an upstream source — in my
case, used to keep a local copy of GitHub repositories in sync without manual intervention

> **Note:** the current setup relies on an external PostgreSQL database that must be provisioned separately. This may
> change in an upcoming refactoring.

## Materials

- [Website](https://about.gitea.com/)

### Docs

- [Docs](https://docs.gitea.com/?_gl=1*l93lar*_gcl_au*MTU1NDI3NTM5NC4xNzM1NDA0NTE1)
- [Gitea Tutorials](https://about.gitea.com/resources/tutorials)

### Docker Hub

- [Docker Hub](https://hub.docker.com/r/gitea/gitea)

### YouTube

- [Gitea Tutorial](https://youtu.be/Kg0ct2lBUVg?si=gNJU1OvwB3eLOcII)