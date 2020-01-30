install:
	docker-compose run web mix deps.get
	docker-compose run web mix ecto.create
	docker-compose run web mix ecto.migrate
	cd assets && npm install && cd ..
run:
	docker-compose up

compose-test:
	docker-compose run web mix test

compose-kill:
	docker-compose kill

compose-bash:
	docker-compose run web bash

compose-iex:
	docker-compose run web iex -S mix

compose-deps:
	docker-compose run web mix deps.get

compose-migrate:
	docker-compsoe run web mix ecto.migrate