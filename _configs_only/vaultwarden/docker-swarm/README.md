# Vaultwarden

- Create database connection URL secret
    - create file `db_url`
    - create secret `cat db_url | docker secret create vaultwarden_db_url -`
    - NOTE: URL encode DB password to prevent errors
- Create admin token secret
    - install argon2
    - execute `echo -n 'MySecretPassword' | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4`
    - create file `token`
        - this approach used because we need to keep "$" which is get replaced otherwise
    - create secret `cat token | docker secret create vaultwarden_admin_token -`
    - Note: you can take a look on the swarm secret value after deploying stack
        - get docker container name: `docker ps`
        - execute `docker exec -it <DOCKER_CONTAINER_NAME> cat /run/secrets/vaultwarden_admin_token`
