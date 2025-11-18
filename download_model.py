import os
from PIL import Image
from DECIMER import predict_SMILES

MODEL_DIR = "/opt/render/.data/DECIMER-V2"
os.makedirs(MODEL_DIR, exist_ok=True)
os.environ["DECIMER_MODEL_PATH"] = MODEL_DIR

# Create a 1x1 white image in memory
dummy_image_path = "/tmp/dummy.png"
Image.new("RGB", (1, 1), color="white").save(dummy_image_path)

# Trigger model download
predict_SMILES(dummy_image_path)
