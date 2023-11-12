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

#### Inspect ```.env``` file and make config changes

```sh
nano .env
```

#### Inspect default ```php.ini``` file and make php config changes

```sh
nano docker/php/config/99-php.ini
```

#### Inspect ```docker-compose.override.yml``` file

```sh
nano docker-compose.override.yml
```


## Start docker services

```sh
docker-compose up
```

> Note: use ```-d``` to fee the terminal

#### Test symfony requirements (Optional)

```sh
docker-compose exec php-service symfony check:requirements
```

## Install symfony

Run this if you are building a microservice, console application or API

```sh
docker-compose exec php-service symfony new . --version="6.3.*"
```

or

run this if you are building a traditional web application

```sh
docker-compose exec php-service symfony new . --version="6.3.*" --webapp
```

> Note: you can also use:

```--version=lts``` 

```--version=stable```

```--version=next```

## Validate installation

```sh
docker-compose exec php-service php bin/console about
```

## Finally navigate to http://localhost:8080/ 

> Note: 8080 is a default value of ```HOST_PORT``` variable from ```.env``` file

# Install additional symfony components

## Profiler

```sh
docker-compose exec php-service composer require --dev symfony/profiler-pack
```