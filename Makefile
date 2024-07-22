.PHONY:build

bash:
	docker exec -it djf_test_app-django bash

build:
	docker build -t mantiby/djf_test_app:latest .

migrate:
	docker exec -it djf_test_app-django python manage.py migrate

static:
	docker exec -it djf_test_app-django python manage.py collectstatic --no-input

deploy:
	docker container stop djf_test_app-django djf_test_app-bot
	docker container rm djf_test_app-django djf_test_app-bot
	docker compose up -d

dump:
	docker exec -it djf_test_app-postgres pg_dump -U djf_test_app -d djf_test_app > database.sql

restore:
	docker cp database.sql djf_test_app-postgres:/tmp/database.sql
	docker exec -it djf_test_app-postgres psql -U djf_test_app djf_test_app -f /tmp/database.sql

messages:
	python manage.py makemessages -a

test:
	pytest --create-db --disable-warnings djf_test_app/

check:
	git add .
	pre-commit run

django-check:
	./manage.py makemigrations --dry-run --check --verbosity=3 --settings=djf_test_app.settings.sqlite
	./manage.py check --fail-level WARNING --settings=djf_test_app.settings.sqlite

pip:
	pip install -r requirements.txt
	pip install -r requirements-dev.txt

update:
	pcu requirements.txt -u
	pre-commit autoupdate
