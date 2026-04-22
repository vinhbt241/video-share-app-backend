# Funny videos - Share your humour!

## Introduction
This repo contains server side source code for Funny Videos - a platform where user can watch funny Youtube videos and share theirs. With Funny Videos, you can:
- Signup & Login.
- Share your favorite Youtube Video.
- Watch all of shared videos - by you and all other users!
- Receive notification in real time when a user share their video

The back-end also offers additional features:
- Displaying API documentation
- Displaying test coverage percentage (local only)

## Prerequisites
There are two approaches for running the project:

### Install dependencies
In order to run this project, you will need to install the following dependencies:
- Ruby: 3.1.2
- Bundler: 2.5.18
- Redis: 7.2.2
- PostgreSQL: 14

### Using docker
Another way is to run the project via Docker. In that case, the list is reduced to:
- Docker (You can use any version - mine is 20.10.21)
- Docker Compose plugin or standalone Docker Compose

## Installation & Configuration
First thing first, let's clone this project:

```
git clone https://github.com/vinhbt241/video-share-app-backend.git
```

Generate Rails credentails secret keys for test & development:

```
EDITOR=nano bin/rails credentials:edit --environment test
EDITOR=nano bin/rails credentials:edit --environment development
```

See `example.\[environment\].yml` for secret variables from each environment.

For Youtube API key, here are the necessary instructions to get one::
1. Log in to Google Developers Console.
2. Create a new project.
3. On the new project dashboard, click Explore & Enable APIs.
4. In the library, navigate to YouTube Data API v3 under YouTube APIs.
5. Enable the API.
6. Create a credential.
7. A screen will appear with the API key.

### Install the dependencies
Intall the necessary dependencies according to the following orders:
- Ruby: [Install instruction](https://www.theodinproject.com/lessons/ruby-installing-ruby)
- Bundler:
```
gem install bundler -v 2.5.18
```
- Redis: [Install instruction](https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/)
- PostresSQL: [Install instruction](https://www.theodinproject.com/lessons/ruby-on-rails-installing-postgresql)
Finally, run the following command:
```
bundle install
```

### Using Docker
Install Docker: [Install insructions](https://docs.docker.com/engine/install/)
Install Docker Compose Plugin: [Install instructions](https://docs.docker.com/compose/install/linux/)
Install Docker Compose standalone: [Install instructions](https://docs.docker.com/compose/install/standalone/)

## Database Setup
Run the following commands:
```
bundle exec rails db:setup
```

## Running the Application
To start a Rails development server & Sidekiq worker, run the following command:
```
./bin/dev
```

### Using Docker
If Docker Compose Plugin is installed:
```
docker compose -f compose.dev.yaml up
```
If Docker Compose standalone is installed:
```
docker-compose -f compose.dev.yaml up
```

## Docker Deployment
This project uses Google Cloud Run & Github repo trigger for CD. When new changes are pushed to main branch, Cloud Run will detect them and spin up new server/worker instances using `Dockerfile.prod`.
For manual deployment, build a new Docker image with the `video-share-app` tag for production:
```
docker build -t video-share-app -f Dockerfile.prod .
```
For running a production container, you can choose to either use an external service for database and cache, such as AWS RDS or ElasticCache, or simply start a container with these services included. Check out the `compose.prod.yaml` file for the first. To start the container, simply run:
```
docker compose -f compose.prod.yaml up -d
```

## Usage
- When started, the server will receive and process API requests coming from Funny Video clients.
- You can check out the API documentation created by Swagger at `http://localhost:3000/api-docs` in development or on [live demo](https://api.video-share-app.store/api-docs/index.html).
- You can check out the test coverage percentage by running the following command:
```
open coverage/index.html
```