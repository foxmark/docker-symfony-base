#!/bin/bash
mkdir app

echo "Do you want create and edit .env file? (y/n): "
read answer

if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
    cp .env.example .env
    nano .env
fi


echo "Do you want create and edit docker-compose.override.yml file? (y/n): "
read answer

if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
    cp docker-compose.override.example.yml docker-compose.override.yml
    nano docker-compose.override.yml
fi

docker compose up -d
docker compose exec php symfony check:requirements
docker compose exec php symfony new . --no-git --version="lts"
docker compose exec php symfony composer require symfony/orm-pack
docker compose exec php symfony composer require symfony/monolog-bundle
docker compose exec php symfony composer require --dev symfony/profiler-pack
docker compose exec php symfony composer require --dev symfony/debug-bundle 
docker compose exec php symfony composer require --dev symfony/test-pack
docker compose exec php symfony composer require --dev symfony/maker-bundle
docker compose exec php symfony composer require --dev doctrine/doctrine-fixtures-bundle

echo "Do you want create new database for the project? (y/n): "
read answer

if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
    docker compose exec php symfony console doctrine:database:create
fi

docker compose exec php symfony console about
