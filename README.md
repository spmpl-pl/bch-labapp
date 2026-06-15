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



### Running Customized Version with Docker Compose

If you want to customize the application and run it with docker compose, follow the instructions below.

#### 1. Prepare Configuration Folder

Create an application foler to store configuration files in your home directory. For example:

```bash
mkdir -p ~/apps/bch-bchapp
cd ~/apps/bch-bchapp
```

#### 2. Prepare User Database

Out of the box, the application includes a static, pre-configured database of 200 mock users, complete with randomized credentials and profile data. This dataset is located in `DBs/UserDB-Default.json`, with passwords securely stored as MD5 hashes. For quick reference, a complete list of predefined usernames and plain-text passwords can be found in `other/Credentials.json`.

If you want to add custom users, follow these steps:

1. Generate md5 hash for the password. Example command to create md5 hash for password `test` is `echo -n "test" | openssl md5` which result with `098f6bcd4621d373cade4e832627b4f6`
2. Create a file `UserDB-Custom.json` and add the user(s) to the file as shown on the example below. Always use IDs higher than 200. 


```json
{
  "201": {
    "first_name": "John",
    "last_name": "Smith",
    "ssn": "218-59-9943",
    "gender": "male",
    "dob": 19841130,
    "phonenum": "(330)410-8681",
    "email": "john.smith@randomdomain.com",
    "cc_number": 5255166842103430,
    "streetaddr": "36563 Alejandrin Points Suite 520",
    "city": "Warszawa",
    "state": "MZ",
    "zipcode": "26039-3972",
    "country": "Poland",
    "username": "johns",
    "password": "098f6bcd4621d373cade4e832627b4f6"
  }
}
```

Optionally, you can validate your file format with the following command:
```bash
jq . UserDB-Custom.json
```

#### 3. Create Docker Compose Definition. 

Plaese create the docker compose file in your appliation directory created in step 1. 

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
      - ~/apps/bch-labapp/UserDB-Custom.json:/app/DBs/UserDB-Custom.json:ro     # Needed only if you want to use a custom user database

    networks: 
      - default

    environment:
      OPENAI_API_KEY: ""              # Needed for Chatbot
      AIFIREWALL_BASE_URL: ""         # Needed for Chatbot
      AIFIREWALL_API_KEY: ""          # Needed for Chatbot
      ORIGINAL_LLM_PROVIDER_URL: ""   # Needed for Chatbot
      APPNAME: "MyAppName"            # Set name for your app. Optional. 

networks:
  default:
    name: bch-labapp-network
```



#### Start the application with:

In you application directory you should have the following files:
1. `UserDB-Custom.json` (if you want to mount Custom User DB)
2. `docker-compose.yml`

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

