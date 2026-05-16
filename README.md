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

A prebuilt Docker image is available for quick deployment.

### Quick Start

If you just want to run the application without any customizations, run the following command:

```bash
docker run -d \
  --name bch-labapp \
  -p 8000:8000 \
  bartoszchm/bch-labapp
```

Then browse to:

```text
http://localhost:8000
```

---

### Customize the Application

If you want to customize the application, follow the instructions below.

#### 1. Prepare Configuration

Some features — especially the AI Firewall demonstrations — require a configuration file. The image ships with a default configuration file, but you can create and use a custom configuration file.

If you want to use a custom configuration, follow these steps:

1. Copy the `config-templates/config.json` file to your local project directory.
2. Adjust the configuration file as needed.
3. Mount the file into your container using volumes (see examples below).

---

#### 2. Prepare User Database

Out of the box, the application includes a static, pre-configured database of 200 mock users, complete with randomized credentials and profile data. This dataset is located in `config-templates/UserDB.json`, with passwords securely stored as MD5 hashes. For quick reference, a complete list of predefined usernames and plain-text passwords can be found in `other/Credentials.json`.

If you want to add custom users, follow these steps:

1. Copy the `config-templates/UserDB.json` file to your local project directory.
2. Add additional users to the file. Passwords must be MD5-hashed.
3. Mount the file into your container using volumes (see examples below).

---

### Run the Application Using Docker

Run the application using Docker:

```bash
docker run -d \
  --name bch-labapp \
  -p 8000:8000 \
  --restart unless-stopped \
  -v ./config.json:/app/config/config.json:ro \
  -v ./UserDB.json:/app/DBs/UserDB.json:ro \
  bartoszchm/bch-labapp
```

> 💡 **Note:** Only include the `-v` lines if you are using a custom `config.json` or `UserDB.json`. Otherwise, omit those parameters.

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
      - ./config.json:/app/config/config.json:ro  # Needed only if you want to use a custom configuration
      - ./UserDB.json:/app/DBs/UserDB.json:ro     # Needed only if you want to use a custom user database
```

> 💡 **Note:** Only include the `volumes` lines if you are using a custom `config.json` or `UserDB.json`. Otherwise, omit them.

Start the application with:

```bash
docker compose up -d
```

---

## Notes

- The container is intended to run behind a reverse proxy such as NGINX or Apache in production environments.
- Binding the service to `127.0.0.1` is recommended when using a reverse proxy.
