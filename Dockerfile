# Use Python 3.10 for RDKit + TensorFlow compatibility
FROM python:3.10-slim

# Install Linux dependencies needed by RDKit
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3-dev \
    libxrender1 \
    libsm6 \
    libxext6 \
    libglib2.0-0 \
    libboost-all-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
# RDKit from PyPI, TensorFlow CPU, Flask, DECIMER dependencies
RUN pip install --upgrade pip
RUN pip install rdkit-pypi tensorflow-cpu flask pillow numpy
RUN pip install gunicorn

# Install DECIMER (via pip)
RUN pip install decimer  # DECIMER PyPI package

# Copy your project files
WORKDIR /app
COPY . /app

# Expose the port Render will use
EXPOSE 10000

# Run your app with Gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
