# Funny videos - Share your humour!

## Introduction
This repo contains server side source code for Funny Videos - a platform where user can watch funny Youtube videos and share theirs. Repo's main features include:
- Receiving and processing API requests
- Displaying API documentation
- Displaying test coverage percentage (development only)

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
Navigate to the project's directory and run the following command:
```
cp .example.env .env
```
Add your credentials to the newly created `.env` file. For YOUTUBE_API_KEY, here are the necessary instructions to get one::
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
rails db:create
rails db:migrate
```

## Running the Application
To start a Rails development server, run the following command:
```
rails s
```
To start a worker instance with Sidekiq, run the following command:
```
bundle exec sidekiq
```

### Using Docker
If Docker Compose Plugin is installed, then run:
```
docker compose -f compose.dev.yaml up
```
If Docker Compose standalone is installed, then run:
```
docker-compose -f compose.dev.yaml up
```

## Docker Deployment
Run the following command to build a new Docker image with the `video-share-app` tag for production:
```
docker build -t video-share-app -f Dockerfile.prod .
```
For running a production container, you can choose to either use an external service for database and cache, such as AWS RDS or ElasticCache, or simply start a container with these services included. Check out the `compose.prod.yaml` file for the second approach. To start the container, simply run:
```
RAILS_MASTER_KEY={YOUR_MASTER_KEY} JWT_SECRET={YOUR_JWT_SECRET} YOUTUBE_API_KEY=${YOUR_YOUTUBE_API_KEY} docker compose -f compose.prod.yaml up -d
```

## Usage
- When started, the server will receive and process API requests coming from Funny Video clients.
- You can check out the API documentation created by Swagger at `http://localhost:3000/api-docs` in development or follow [this URL](http://ec2-13-212-49-232.ap-southeast-1.compute.amazonaws.com:3000/api-docs/index.html).
- You can check out the test coverage by running the following command:
```
open coverage/index.html
```