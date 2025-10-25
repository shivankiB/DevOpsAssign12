# Use an official Python base image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y libpq-dev gcc

# Copy requirements file if you have one (optional)
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install Django and PostgreSQL driver directly
RUN pip install django psycopg2-binary gunicorn

# Copy all project files into container
COPY . /app

# Expose port 8000
EXPOSE 8000

# ✅ Wait for DB, run migrations, and start the app
CMD ["bash", "-c", "sleep 10 && gunicorn --workers 3 --timeout 120 --bind 0.0.0.0:8000 mysite.wsgi:application"]
