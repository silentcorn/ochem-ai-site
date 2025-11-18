FROM python:3.10-slim

# System dependencies for RDKit, TensorFlow (used by DECIMER), and drawing
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

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all program files
COPY . .

# Render sets $PORT automatically
ENV PORT=10000
EXPOSE 10000

# Start Gunicorn (matches: app.py -> app variable)
CMD ["bash", "-lc", "gunicorn --bind 0.0.0.0:$PORT app:app"]
