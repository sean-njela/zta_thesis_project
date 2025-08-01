# ------------------------------------------------------------------
# Base image - use slim or alpine if size matters, but balance with compatibility
# ------------------------------------------------------------------
FROM python:3.12-alpine3.21

# ------------------------------------------------------------------
# Set environment variables
# Prevents Python from writing .pyc files and enables logging
# ------------------------------------------------------------------
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# ------------------------------------------------------------------
# Set working directory inside the container
# ------------------------------------------------------------------
WORKDIR /usr/src/app

# ------------------------------------------------------------------
# Install system dependencies and Python deps
# Slim images often need build tools for packages like psycopg2
# ------------------------------------------------------------------
RUN apk add --no-cache \
    gcc \
    musl-dev \
    libpq-dev \
    netcat-openbsd \
    curl

# Install Poetry via official install script
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Copy only the files necessary for installing dependencies
COPY pyproject.toml poetry.lock ./

# Disable Poetry's virtualenv creation
# Install dependencies WITHOUT dev dependencies (production mode)
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --without dev --no-interaction --no-ansi

# ------------------------------------------------------------------
# Copy application code (assumes it's in ../src/)
# Use .dockerignore to avoid copying unnecessary files
# ------------------------------------------------------------------
COPY src/ ./

# ------------------------------------------------------------------
# Expose port
# ------------------------------------------------------------------
EXPOSE 5000

# ------------------------------------------------------------------
# Default command (can be overridden in docker-compose)
# exec "$@" in entrypoint.sh will run this
# ------------------------------------------------------------------
CMD ["python", "app.py"]
