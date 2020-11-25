default: up

up:
	docker-compose up

down:
	docker-compose down

init: build bundle rails_init db_init

build:
	docker-compose build --no-cache

bundle:
	docker-compose run --rm rails bundle install
	docker-compose run --rm rails yarn install

db_init:
	docker-compose run --rm rails bundle exec rake db:create
	docker-compose run --rm rails bundle exec rake db:migrate

rails_init:
	docker-compose run rails rails new . --force --database=postgresql