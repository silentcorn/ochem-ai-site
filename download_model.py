import os
from DECIMER import predict_SMILES

# Set DECIMER model path inside Render persistent storage
MODEL_DIR = "/opt/render/.data/DECIMER-V2"
os.makedirs(MODEL_DIR, exist_ok=True)

# Trigger model download
print("Downloading DECIMER model...")
predict_SMILES("https://raw.githubusercontent.com/XYZ/placeholder.png", model_dir=MODEL_DIR)
print("Model download complete!")
