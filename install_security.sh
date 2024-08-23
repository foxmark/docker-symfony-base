#!/bin/bash
docker compose exec php symfony composer require security
docker compose exec php symfony console make:user
docker compose exec php symfony console make:security:form-login
