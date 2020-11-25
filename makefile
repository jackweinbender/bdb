default: up

up:
	docker-compose up

down:
	docker-compose down

init: build bundle rails_init instructions

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

instructions: 
	@echo "********************************************"
	@echo "** To complete configuration, update your **"
	@echo "** `config/databases.yml` file to match   **"
	@echo "** the values supplied as ENV variables   **"
	@echo "** and add `host: db` to the default conf.**"
	@echo "** Finally, run `make db_init`.					 **"