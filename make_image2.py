import json
import requests
from PIL import Image
import io
import re
from time import time
import urllib.request
from googletrans import Translator

def make_image(prompt, index):
    API_TOKEN = ""  # token in case you want to use private API
    translator = Translator(service_urls=['translate.google.com'])
    prompt = translator.translate(prompt, dest='en').text
    headers = {
        # "Authorization": f"Bearer {API_TOKEN}",
        "X-Wait-For-Model": "true",
        "X-Use-Cache": "false"
    }
    API_URL = "https://api-inference.huggingface.co/models/runwayml/stable-diffusion-v1-5"


    def query(payload):
        data = json.dumps(payload)
        response = requests.request("POST", API_URL, headers=headers, data=data)
        return Image.open(io.BytesIO(response.content))


    
    image = query({"inputs": prompt})
    filepath = "./make_img"
    filename = "image" + str(index) + ".jpg"

    image.save(filepath + "/" + filename)

if __name__ == "__main__":
    prompt = "a white siamese cat"
    make_image(prompt, 1)