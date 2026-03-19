# OpenSSH Configuration

By default, the SSH client reads `~/.ssh/config` for connection settings. This guide shows how to keep that file
minimal and delegate host definitions to separate per-group config files — picked up automatically via a glob
`include` directive — and how to connect to any configured host using a short alias.

## Proposed OpenSSH Directory Structure

This structure keeps the SSH setup simple, flexible, and portable — adding a new config is just dropping a file into
`cfg/`, and the entire `~/.ssh/` directory can be version-controlled or moved to a new machine without any changes to
the main config

```
~/.ssh/
├── config              # main config — includes all *.config files from cfg/
├── cfg/
│   ├── homelab.config  # host definitions for homelab machines
│   └── work.config     # host definitions for work machines
└── keys/
    ├── homelab_key
    └── work_key
```

> The config files shown inside `cfg/` are examples — feel free to split and name them however makes sense for your
> setup (by environment, by project, by client, etc.)

## Configuration

### 1. Configure the main SSH config file

Edit `~/.ssh/config` so it picks up every file inside `~/.ssh/cfg/` automatically:

```
include ~/.ssh/cfg/*.config
```

> The `include` directive accepts glob patterns and is expanded relative to `~/.ssh/` when an absolute path is not
> given. Any `*.config` file dropped into `cfg/` is loaded on the next SSH connection — no further changes to the
> main config are needed

### 2. Create the cfg and keys directories

```bash
mkdir -p ~/.ssh/cfg
mkdir -p ~/.ssh/keys
```

### 3. Add host config files

Create a file per logical group inside `~/.ssh/cfg/`. Each file follows the same `Host` block syntax as the main
config. Example — `~/.ssh/cfg/homelab.config`:

```
Host server1
    HostName 192.168.0.100
    User username
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/keys/homelab_key_1

Host server2
    HostName 192.168.0.101
    User username
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/keys/homelab_key_2
```

Key fields:

- `Host` — the alias used on the command line
- `HostName` — the actual IP address or hostname to connect to
- `User` — the remote user to log in as
- `PreferredAuthentications` — authentication method (`publickey` disables password prompts)
- `IdentityFile` — path to the private key for this host

### 4. Set correct permissions

> **Linux / macOS only** — Windows users can skip this step; the native OpenSSH client manages permissions through
> Windows ACLs automatically

SSH enforces strict permission checks on config files and keys:

```bash
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/cfg/*.config
chmod 600 ~/.ssh/keys/*
```

### 5. Connect using a host alias

With hosts defined, connecting requires only the alias:

```bash
ssh server1
```

This is equivalent to:

```bash
ssh username@192.168.0.100 -i ~/.ssh/keys/homelab_key_1
```

Other SSH-based tools (`scp`, `rsync`, etc.) resolve aliases from the config the same way:

```bash
scp ~/file.txt server1:/home/username/
rsync -av ~/dir/ server2:/home/username/dir/
```

## Multiple Keys for the Same Host

The same host can appear under multiple aliases, each using a different key. This is useful when you have separate
accounts on a single service — for example, a personal and a work GitHub account

```
Host github.com
    HostName github.com
    IdentityFile ~/.ssh/keys/github_personal

Host github.com-work
    HostName github.com
    IdentityFile ~/.ssh/keys/github_work
```

Both blocks point to the same `HostName`, but the alias in the `Host` field controls which key is used. When cloning
or pushing, use the alias instead of the real hostname. See [`resources/cfg/work.config`](resources/cfg/work.config)
for a full example:

```bash
# personal account
git clone git@github.com:personal-org/repo.git

# work account
git clone git@github.com-work:work-org/repo.git
```

## Materials

The [`resources/`](resources) directory mirrors the proposed `~/.ssh/` structure and can be used as a starting point:

- [`resources/config`](resources/config) — main config with the `include` directive
- [`resources/cfg/example.config`](resources/cfg/example.config) — example host config file
- [`resources/cfg/work.config`](resources/cfg/work.config) — example showing multiple keys for the same host
- [`resources/keys/`](resources/keys) — directory for storing SSH keys

## Materials

### Articles

- [ssh_config(5) - Linux man page](https://linux.die.net/man/5/ssh_config)
- [How To Configure Custom Connection Options for your SSH Client](https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client)
- [How to Manage an SSH Config File in Windows and Linux](https://www.howtogeek.com/devops/how-to-manage-an-ssh-config-file-in-windows-linux/)
- [How To Easily Transfer Files Over SSH Using SCP](https://cyberpanel.net/blog/transfer-files-over-ssh)
