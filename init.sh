#!/bin/bash

mkdir app

env_file=".env"

if [[ ! -f "$env_file" ]]; then
    cp .env.example .env
    nano .env
fi

source .env

override_file="docker-compose.override.yml"

if [[ ! -f "$override_file" ]]; then
    echo "Do you want create and edit docker-compose.override.yml file? (y/n): "
    read q2

    if [[ "$q2" == "y" || "$q2" == "yes" ]]; then
        cp docker-compose.override.example.yml docker-compose.override.yml
        nano docker-compose.override.yml
    fi
fi

docker compose up -d
docker compose exec php symfony check:requirements
docker compose exec php symfony new . --no-git --version="lts"
docker compose exec php symfony composer require symfony/monolog-bundle
docker compose exec php symfony composer require --dev symfony/maker-bundle

echo "Do you want install debug and test tools? (y/n): "
read q3

if [[ "$q3" == "y" || "$q3" == "yes" ]]; then
    docker compose exec php symfony composer require --dev symfony/profiler-pack symfony/debug-bundle symfony/test-pack
fi

echo "Do you want install doctrine? (y/n): "
read q4

if [[ "$q4" == "y" || "$q4" == "yes" ]]; then
    docker compose exec php symfony composer require symfony/orm-pack --no-interaction --no-scripts
    docker compose exec php symfony composer require --dev doctrine/doctrine-fixtures-bundle

    echo "Do you want create new database for the project? (y/n): "
    read q5

    if [[ "$q5" == "y" || "$q5" == "yes" ]]; then
        docker compose exec php symfony console doctrine:database:create
    fi
fi

echo "Do you want install API Platform bundle? (y/n): "
read q6

if [[ "$q6" == "y" || "$q6" == "yes" ]]; then
    docker compose exec php symfony composer require api
    #docker compose exec php symfony composer require lexik/jwt-authentication-bundle
    #docker compose exec php symfony console lexik:jwt:generate-keypair
fi

echo "Do you want install JWT bundle? (y/n): "
read q7

if [[ "$q7" == "y" || "$q7" == "yes" ]]; then
    docker compose exec php symfony composer require lexik/jwt-authentication-bundle
    docker compose exec php symfony console lexik:jwt:generate-keypair
fi

echo "Do you want copy basic template files? (y/n): "
read q5

if [[ "$q5" == "y" || "$q5" == "yes" ]]; then
    templates_dir="app/templates"

    if [[ ! -d "$templates_dir" ]]; then
        mkdir -p "app/templates"
    fi
    cp misc/basic_template/* app/templates
fi

chown -R $USER:$USER app/

docker compose exec php symfony console about

echo "Access your app: http://localhost:$HOST_PORT"
echo
echo "****INSTALLATION COMPLETED****"
echo
