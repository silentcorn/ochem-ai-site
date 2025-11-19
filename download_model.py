import os
from PIL import Image
from DECIMER import predict_SMILES

# Folder to store the model
MODEL_DIR = "/opt/decimer-model"
os.makedirs(MODEL_DIR, exist_ok=True)
os.environ["DECIMER_MODEL_PATH"] = MODEL_DIR

# Create a tiny dummy image to trigger model download
dummy_image_path = "/tmp/dummy.png"
Image.new("RGB", (1, 1), color="white").save(dummy_image_path)

# This triggers DECIMER to download the model
predict_SMILES(dummy_image_path)
#