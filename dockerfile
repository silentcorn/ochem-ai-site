# Base image
FROM python:3.10-slim

# Install system deps
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
    libboost-all-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Pre-download DECIMER model
RUN mkdir -p /opt/decimer-model && python download_model.py

# Expose port
EXPOSE 5000

# Start Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "app:app", "--workers", "2"]
