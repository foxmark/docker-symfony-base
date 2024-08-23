#!/bin/bash
docker compose up -d
docker compose exec php symfony check:requirements
docker compose exec php symfony new . --no-git --version="lts"
docker compose exec php symfony console about
docker compose exec php symfony composer require --dev symfony/profiler-pack
docker compose exec php symfony composer require --dev symfony/debug-bundle 
docker compose exec php symfony composer require --dev symfony/test-pack
docker compose exec php symfony composer require --dev symfony/maker-bundle
docker compose exec php symfony composer require --dev doctrine/doctrine-fixtures-bundle
docker compose exec php symfony composer require --no-interaction symfony/orm-pack
# docker compose exec php symfony composer require easycorp/easyadmin-bundle
