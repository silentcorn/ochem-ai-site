# Use a python base
FROM python:3.10-slim

# Install system dependencies required by RDKit, TensorFlow, OpenCV, DECIMER
RUN apt-get update && apt-get install -y \
    libxrender1 \
    libxext6 \
    libsm6 \
    libglib2.0-0 \
    libgl1 \
    libfreetype6 \
    libpng16-16 \
    openjdk-11-jre \
    tesseract-ocr \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create app dir
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app code
COPY . .

# Expose Render port
ENV PORT=10000

# Run Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
