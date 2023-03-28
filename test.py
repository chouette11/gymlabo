import openai
openai.api_key = "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"

import requests
from requests.structures import CaseInsensitiveDict

import json

import urllib.request

from googletrans import Translator


openai.api_key = "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"
response = openai.Image.create(
  prompt="a white siamese cat",
  n=1,
  size="512x512"
)
image_url = response['data'][0]['url']

filepath = "./make_img"
filename = "image" + str(1) + ".jpg"

urllib.request.urlretrieve(image_url,  filepath + "/" + filename)



