Upgrade notes: Django 3.2 -> 4.2

Summary
- Bumped `Django==3.2` -> `Django==4.2` in `requirements.txt`.
- Added `Dockerfile` and `docker-compose.yml` for local development with Postgres.
- Added `.dockerignore`.

Quick dev steps

1. Build and run with Docker Compose (dev DB):

   docker compose up --build

2. Run checks/migrations inside container (if needed):

   docker compose run --rm web python manage.py check
   docker compose run --rm web python manage.py migrate

Notes
- After upgrading to Django 4.2 you may need to update any deprecated settings or import paths.
- Run test suite and fix deprecation warnings before deploying.
