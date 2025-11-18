FROM python:3.10-slim

# system deps for RDKit, TensorFlow, DECIMER
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
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Expose the Render port (optional, mostly documentation)
EXPOSE 10000

# Use shell form for PORT expansion
CMD gunicorn --bind 0.0.0.0:$PORT app:app
