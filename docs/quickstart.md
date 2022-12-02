# Quickstart

Install [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/), then run:

```
git clone https://github.com/veeral-patel/incidents && cd incidents
chmod +x install.sh && sudo ./install.sh
```

This script will create a Docker container running INCIDENTS and provision an initial user account.

Now visit [http://localhost:80](http://localhost:80) and log in with the outputted credentials.

**Don't follow these instructions to install INCIDENTS in production!** Data and files are stored on disk and SSL isn't set up.

### Common errors while installing

#### "Couldn't connect to the Docker daemon"

- Be sure Docker is running. Run `sudo systemctl start docker`, start Docker
  Desktop, or run the equivalent command to start Docker for your OS.
- Docker requires root access to run. Make you're running `sudo ./install.sh`, not `./install.sh`.

#### Docker container "killed" during installation

- Clear disk space if you're running low on it
- Add more memory (if installing in a VM) or terminate unused,
  memory-intensive processes

### Dark theme

See [this page](https://tryincidents.com/dark_theme/) to
install INCIDENTS so it uses the dark theme.

(Spoiler: you only have to add one word to the two commands above!)
