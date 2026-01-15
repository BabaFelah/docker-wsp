COMPOSE_FILE := pipeline/docker-compose.yaml

.PHONY: help build up up-build logs down

help:
	@echo "Makefile commands:"
	@echo "  build     - Build images defined in $(COMPOSE_FILE)"
	@echo "  up        - Start services in detached mode"
	@echo "  up-build  - Start services and rebuild images"
	@echo "  logs      - Follow service logs"
	@echo "  down      - Stop and remove containers/networks"

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

up-build:
	docker compose -f $(COMPOSE_FILE) up --build -d

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

down:
	docker compose -f $(COMPOSE_FILE) down
