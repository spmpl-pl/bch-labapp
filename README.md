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

## Quick Start

Run the application using:

```bash
docker run -d \
  --name bch-labapp \
  -p 127.0.0.1:8000:8000 \
  --restart unless-stopped \
  -v \[PATH\]config.json:/app/config/config.json:ro \
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

---

