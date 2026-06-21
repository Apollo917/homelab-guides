# PostgreSQL

## Setup

- Create databases network
    - `docker network create --driver overlay --attachable databases`
- Create postgres user secret
  - `printf "<POSTGRES_USER>" | docker secret create postgres_user -`
- Create postgres password secret
    - `printf "<POSTGRES_PASSWORD>" | docker secret create postgres_pwd -`

## Materials

- https://www.postgresql.org/
- https://www.postgresql.org/docs/
- https://hub.docker.com/_/postgres
- https://github.com/TimWolla/docker-adminer