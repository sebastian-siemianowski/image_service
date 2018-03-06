ifeq ($(OS),Windows_NT)
    detected_OS := Windows
else
    detected_OS := $(shell uname -s)
	OS_Permissions = "sudo"
endif

.PHONY: test test-rails sencha-build up down docker-up couchbase-backup couchbase-restore bounce-rails

up: |docker-up

test: test-rails test-integration
	@echo "All tests passing"

test-integration:
	$(OS_Permissions) docker-compose run integration cucumber

test-rails:
	$(OS_Permissions) docker-compose run rails spec

create-db:
    $(OS_Permissions) docker-compose run rails rake db:create
    $(OS_Permissions) docker-compose run rails rake db:migrate

migrate-db:
    $(OS_Permissions) docker-compose run rails db:migrate

docker-up:
	$(OS_Permissions) docker-compose up

build: down
	$(OS_Permissions) docker-compose build

bounce-rails:
	$(OS_Permissions) docker-compose stop rails
	$(OS_Permissions) rm -f backend/tmp/pids/server.pid
	$(OS_Permissions) docker-compose build rails
	$(OS_Permissions) docker-compose up -d rails

down:
	$(OS_Permissions) docker-compose down --remove-orphans
	@echo "\nRemoving rails server.pid just in case"
	$(OS_Permissions) rm -f backend/tmp/pids/server.pid

build-testing: build
	$(OS_Permissions) docker-compose run build testing
	$(OS_Permissions) rm -rf backend/public/*
	$(OS_Permissions) mv frontend/build/web-testing/ConnectMobile/* backend/public/

serve-testing: build-testing
	$(OS_Permissions) docker-compose -f docker-compose-testing.yml up -d
