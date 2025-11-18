FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libxrender1 \
    libxext6 \
    libsm6 \
    libglib2.0-0 \
    libgl1 \
    libfreetype6 \
    libpng16-16 \
    default-jre \
    tesseract-ocr \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Render injects $PORT automatically — don't override it
EXPOSE $PORT
# SHELL FORM CMD → environment variables expand correctly
CMD gunicorn --bind 0.0.0.0:$PORT app:app