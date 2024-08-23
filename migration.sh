#!/bin/bash
docker compose exec php symfony console make:migration --no-interaction
docker compose exec php symfony console doctrine:migrations:migrate --no-interaction --allow-no-migration --all-or-nothing