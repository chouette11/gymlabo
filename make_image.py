import openai
openai.api_key = "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"

import requests
from requests.structures import CaseInsensitiveDict

import json

import urllib.request

from googletrans import Translator


QUERY_URL = "https://api.openai.com/v1/images/generations"

def make_image(prompt, index):
    translator = Translator(service_urls=['translate.google.com'])
    text = translator.translate(prompt, dest='en').text
    headers = CaseInsensitiveDict()
    headers["Content-Type"] = "application/json"
    api_key = "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"
    headers["Authorization"] = f"Bearer {api_key}"

    data = """
    {
        """
    data += f'"model": "image-alpha-001",'
    data += f'"prompt": "{text}",'
    data += """
        "num_images":1,
        "size":"512x512",
        "response_format":"url"
    }
    """

    resp = requests.post(QUERY_URL, headers=headers, data=data)

    if resp.status_code != 200:
        raise ValueError("Failed to generate image " + resp.text)

    response_text = json.loads(resp.text)
    image_url = response_text['data'][0]['url']

    filepath = "./make_img"
    filename = "image" + str(index) + ".jpg"

    urllib.request.urlretrieve(image_url,  filepath + "/" + filename)

if __name__ == "__main__":
    prompt = "a white siamese cat"
    make_image(prompt, 1)



