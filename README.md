# Lab Site Project

The Lab Site Project is a demonstration environment designed to showcase modern web application protection and security capabilities in realistic scenarios.

It can be used for testing, training, presentations, proof-of-concept deployments, and security feature demonstrations.

The platform currently includes demonstrations for:

- API Security
- Web Application Firewall (WAF) protection
- Advanced Bot Protection
- AI Firewall scenarios
- Reverse proxy integrations
- Containerized application deployments

Additional modules and documentation will be added over time.

---

## Running the Application

A prebuilt Docker image is available for quick deployment using Docker.

### 1. Prepare Configuration

Some features — especially the AI Firewall demonstrations — require a configuration file.

You can find configuration templates in:

```text
config-templates/
```

Create your configuration file before starting the container.

---

### 2. Prepare User Database

Out of the box, the application includes a static, pre-configured database of 200 mock users, complete with randomized credentials and profile data. This dataset is located in config-templates/UserDB.json, with passwords securely stored as MD5 hashes. For quick reference, a complete list of these predefined usernames and plain-text passwords can be found in other/Credentials.json.

If you want to add custom users, follow the the following steps:
1. Download the config-templates/UserDB.json file to your local disk.
2. Add additional users to the file. The password is MD5 hash.
3. Run a docker with virtual volume by -v parameter as docker command or by defining the additional volume in docker compose file like config.json:/app/config/config.json:ro


## Quick Start

Run the application using:

```bash
docker run -d \
  --name bch-labapp \
  -p 127.0.0.1:8000:8000 \
  --restart unless-stopped \
  -v config.json:/app/config/config.json:ro \
  bartoszchm/bch-labapp
```

---

## Recommended: Docker Compose

For production or long-term deployments, using Docker Compose is recommended.

Example `docker-compose.yml`:

```yaml
services:
  bch-labapp:
    image: bartoszchm/bch-labapp:latest
    container_name: bch-labapp

    restart: unless-stopped

    ports:
      - "127.0.0.1:8000:8000"

    volumes:
      - ./config/config.json:/app/config/config.json:ro
```

Start the application with:

```bash
docker compose up -d
```

---

## Notes

- The container is intended to run behind a reverse proxy such as NGINX or Apache in production environments.
- Binding the service to `127.0.0.1` is recommended when using a reverse proxy. 
- Persistent configuration should be mounted using Docker volumes instead of copying files into the container.



