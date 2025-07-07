# Dockerfile

## 🔍 Explanation

| Line	| Purpose |
| --- | --- |
| gcc libpq-dev	| Required for compiling some packages like psycopg2 |
| netcat	| Optional – useful if your entrypoint.sh uses it to wait for services |
| curl	| Optional – useful in some CI/CD or healthcheck scripts |
| poetry config virtualenvs.create false	| Forces Poetry to install into the system Python environment inside the Docker image (rather than a virtualenv) |
| --without dev	| Ensures you're not installing dev-only packages |
| --no-root	| Skips installing the current app package itself (unless you need it for CLI tools etc.) |
| --no-interaction --no-ansi	| Makes logs CI-friendly and clean |
