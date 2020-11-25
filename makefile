default: up

up:
	docker-compose up

down:
	docker-compose down

# after init, configure your db settings and run db_init
init: chown build bundle rails_init

chown:
	sudo chown ${USER}:${USER} -R .

build:
	docker-compose build

bundle:
	docker-compose run --rm rails bundle install

db_init:
	docker-compose run --rm rails bundle exec rake db:create
	docker-compose run --rm rails bundle exec rake db:migrate

rails_init:
	docker-compose run --rm rails bundle exec rails new . \
		--force --database=postgresql