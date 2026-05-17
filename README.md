# Lab Site Project

The Lab Site Project is a demonstration environment designed to showcase modern web application protection and security capabilities in realistic scenarios.

It can be used for testing, training, presentations, proof-of-concept deployments, and security feature demonstrations.

The platform currently includes demonstrations for:

- API Security
- WAF protection
- Advanced Bot Protection
- AI Application Security scenarios
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



### Customize the Application

If you want to customize the application, follow the instructions below.

#### 1. Prepare Configuration Folder

Create an application foler to store configuration files in your home directory. For example:

```bash
mkdir -p ~/apps/bch-bchapp
cd ~/apps/bch-bchapp
```

#### 2. Prepare Configuration File

Some features — especially the AI Firewall demonstrations — require a configuration file. The image ships with a default configuration file, but you can create and use a custom configuration file.

If you want to use a custom configuration, follow these steps:

1. Copy the `config-templates/config.json` file to your local project directory created in step 1. 
2. Adjust the configuration file as needed.


#### 3. Prepare User Database

Out of the box, the application includes a static, pre-configured database of 200 mock users, complete with randomized credentials and profile data. This dataset is located in `config-templates/UserDB.json`, with passwords securely stored as MD5 hashes. For quick reference, a complete list of predefined usernames and plain-text passwords can be found in `other/Credentials.json`.

If you want to add custom users, follow these steps:

1. Copy the `config-templates/UserDB.json` file to your local project directory created in step 1.
2. Generate md5 hash for the password. Example command to create md5 hash for password test is `echo -n "test" | openssl md5` which result with `098f6bcd4621d373cade4e832627b4f6`
3. Add additional users to the file. Example below.

Example entry addedd to `UserDB.json` below the default user list. Please make sure all entries are separated by comma. 

```json
  "201": {
    "first_name": "Bartosz",
    "last_name": "Chmielewski",
    "ssn": "218-59-9943",
    "gender": "male",
    "dob": 19841130,
    "phonenum": "(330)410-8681",
    "email": "bartosz.chmielewski@randomdomain.com",
    "cc_number": 5255166842103430,
    "streetaddr": "36563 Alejandrin Points Suite 520",
    "city": "Warszawa",
    "state": "MZ",
    "zipcode": "26039-3972",
    "country": "Poland",
    "username": "bartoszch",
    "password": "098f6bcd4621d373cade4e832627b4f6"
  }
```

You can validate your file format with the following command:
```bash
jq . UserDB.json
```

#### 4. Create Docker Compose Definition. 

For production or long-term deployments, using Docker Compose is recommended. Plaese create the docker compose file in your appliation directory created in step 1. 

Example `docker-compose.yml`:

```yaml
name: bch-labapp

services:
  bch-labapp:
    image: bartoszchm/bch-labapp:latest
    container_name: bch-labapp

    restart: unless-stopped

    ports:
      - "8000:8000"

    volumes:
      - ~/apps/bch-app/config.json:/app/config/config.json:ro  # Needed only if you want to use a custom configuration
      - ~/apps/bch-app/UserDB.json:/app/DBs/UserDB.json:ro     # Needed only if you want to use a custom user database

    networks: 
      - default

networks:
  default:
    name: bch-labapp-network
```

> 💡 **Note:** Only include the `volumes` lines if you are using a custom `config.json` or `UserDB.json`. Otherwise, omit them.



#### Start the application with:

In you application directory you should have the following files:
1. `config.json` (if you want to customize config)
2. `UserDB.json` (if you want to mount custom User DB)
3. `docker-compose.yml`

Run the following command to pull and start the project. Please ensure you are in the project directory which contains all the files listed above. 

```bash
docker compose up -d
```

Since the `restart: unless-stopped` config is provided, the container will stay up as long as the OS is up or unless stopped manually. 

Now you can access your application with the address `http://localhost:8000`. 


## Upgrading the App

If you use docker compose, please issue the commands below to upgrade the app to the newest version. 

```bash
docker compose pull
docker compose up -d
```

