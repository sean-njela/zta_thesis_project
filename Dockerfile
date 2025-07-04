# Dockerfile
FROM python:3.12-alpine3.21

WORKDIR /app

# Install poetry
RUN pip install poetry

# Copy only the files necessary for installing dependencies
COPY pyproject.toml poetry.lock ./

# Install dependencies
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --without dev --no-interaction --no-ansi

# Copy the application code
COPY final/ ./

EXPOSE 5000

CMD ["python", "app.py"]