# Use an official Python base image
FROM python:3.11-slim

# Install system dependencies for RDKit, OpenCV, DECIMER
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements.txt and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app code
COPY . .

# Expose the port Render expects
ENV PORT=10000

# Run the app with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
