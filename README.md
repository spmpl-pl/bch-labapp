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

### 1. Prepare Configuration

Some features — especially the AI Firewall demonstrations — require a configuration file. The image ships with a default configuratoin file but you can alter it. You can find configuration templates in the `config-templates/` directory.  Create your local `config.json` file before starting the container. 

---

### 2. Prepare User Database

Out of the box, the application includes a static, pre-configured database of 200 mock users, complete with randomized credentials and profile data. This dataset is located in `config-templates/UserDB.json`, with passwords securely stored as MD5 hashes. For quick reference, a complete list of these predefined usernames and plain-text passwords can be found in `other/Credentials.json`.

If you want to add custom users or persist new users created at runtime, follow these steps:
1. Copy the `config-templates/UserDB.json` file to your local project directory.
2. Add additional users to the file. Passwords must be MD5 hashed.
3. Mount the file into your container using volumes (see examples below).

---

## Quick Start

Run the application using Docker:

```bash
docker run -d \
  --name bch-labapp \
  -p 127.0.0.1:8000:8000 \
  --restart unless-stopped \
  -v ./config.json:/app/config/config.json:ro \
  -v ./UserDB.json:/app/DBs/UserDB.json \
  bartoszchm/bch-labapp

> 💡 **Note:** Only include the -v lines if you are using a custom config.json or UserDB.json. Otherwise, ship the respective -v parameters. 

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
      - config.json:/app/config/config.json:ro  # needed only if you want to add custom configuration parameters
      - UserDB.json:/app/DBs/UserDB.json:ro     # needed only if you want custom User Database. See the "Prepare User Database". 

```
> 💡 **Note:** Only include the volumes lines if you are using a custom config.json or UserDB.json. Otherwise, ship the respective -v parameters. 



Start the application with:

```bash
docker compose up -d
```

---

## Notes

- The container is intended to run behind a reverse proxy such as NGINX or Apache in production environments.
- Binding the service to `127.0.0.1` is recommended when using a reverse proxy. 
- Persistent configuration should be mounted using Docker volumes instead of copying files into the container.



