# Installation

## Clone project

```sh 
git clone https://github.com/foxmark/docker-symfony-base.git
```

## Change directory

```sh
cd docker-symfony-base
```

## Edit Configuration

#### Rename and inspect ```.env``` file

```sh
cp .env.example .env
```

```sh
nano .env
```

#### Inspect default ```php.ini``` file and make php config changes

```sh
nano docker/php/config/99-php.ini
```

# Optional step
## Enable mysql connection using docker

If you want you could use my other docker setup to run mysql 8 container [docker-mysql-base](https://github.com/foxmark/docker-mysql-base)

> Note: Fallow my [README](https://github.com/foxmark/docker-mysql-base/blob/master/README.md) file and start mysql container first - both repositories are setup to work together without making any changes to the configuration (```.env```) file(s)

> Note2: This will also enable xdebug extension

#### Rename and inspect ```docker-compose.override.yml``` file

```sh
cp docker-compose.override.example.yml docker-compose.override.yml
```

```sh
nano docker-compose.override.yml
```


# Start docker services

```sh
docker compose up
```

> Note: use ```-d``` to fee the terminal

# Test symfony requirements (Optional)

```sh
docker compose exec php symfony check:requirements
```

# Install symfony

Run this if you are building a microservice, console application or API

```sh
# current LTS => 6.4.1
docker compose exec php symfony new . --version="lts"
```

or

run this if you are building a traditional web application

```sh
docker compose exec php symfony new . --version="lts" --webapp
```

> Note: you can also use:

```--version=lts``` 

```--version=stable```

```--version=next```

# Validate installation

```sh
docker compose exec php php bin/console about
```

## Finally navigate to http://localhost:8080/ 

> Note: 8080 is a default value of ```HOST_PORT``` variable from ```.env``` file

# Install additional symfony components

## Profiler

```sh
docker compose exec php composer require --dev symfony/profiler-pack
```

## Doctrine (Optional)

If you are using mysql container setup from [this section](#enable-mysql-connection-using-docker)

```sh
docker compose exec php composer require symfony/orm-pack
```
```sh
docker compose exec php composer require --dev symfony/maker-bundle
```

```sh
docker compose exec php php bin/console doctrine:database:create
```

## Useful Debug tools:

```sh
docker compose exec php bin/console debug:router
```

```sh
docker compose exec php bin/console debug:config
```

```sh
docker compose exec php bin/console config:dump
```

```sh
docker compose exec php bin/console cache:clear
```