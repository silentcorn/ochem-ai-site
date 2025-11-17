FROM python:3.10-slim

# Install dependencies for RDKit, TensorFlow, DECIMER (Debian 12 versions)
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

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
