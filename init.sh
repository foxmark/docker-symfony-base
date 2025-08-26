#!/bin/bash

mkdir app

cp .env.example .env
nano .env
source .env

echo "Do you want create and edit docker-compose.override.yml file? (y/n): "
read q2

if [[ "$q2" == "y" || "$q2" == "yes" ]]; then
    cp docker-compose.override.example.yml docker-compose.override.yml
    nano docker-compose.override.yml
fi

docker compose up -d
docker compose exec php symfony check:requirements
docker compose exec php symfony new . --no-git --version="lts"
docker compose exec php symfony composer require symfony/monolog-bundle
docker compose exec php symfony composer require --dev symfony/maker-bundle

echo "Do you want install debug and test tools? (y/n): "
read q3

if [[ "$q3" == "y" || "$q3" == "yes" ]]; then
    docker compose exec php symfony composer require --dev symfony/profiler-pack
    docker compose exec php symfony composer require --dev symfony/debug-bundle 
    docker compose exec php symfony composer require --dev symfony/test-pack
fi

echo "Do you want install doctrine? (y/n): "
read q4

if [[ "$q4" == "y" || "$q4" == "yes" ]]; then
    docker compose exec php symfony composer require symfony/orm-pack
    docker compose exec php symfony composer require --dev doctrine/doctrine-fixtures-bundle

    echo "Do you want create new database for the project? (y/n): "
    read q5

    if [[ "$q5" == "y" || "$q5" == "yes" ]]; then
        docker compose exec php symfony console doctrine:database:create
    fi
fi

echo "Do you want copy basic template files? (y/n): "
read q5

if [[ "$q5" == "y" || "$q5" == "yes" ]]; then
    mkdir app/templates
    cp misc/basic_template/* app/templates
fi

chown -R $USER:$USER app/

docker compose exec php symfony console about

echo "Access your app: http://localhost:$HOST_PORT"
echo
echo "****INSTALLATION COMPLETED****"
echo