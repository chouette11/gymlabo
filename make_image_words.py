from enum import Enum
import openai


def make_image_words(prompt, class_text):
    prompt = class_text + "\n上記の内容から" + prompt + "を理解するために重要な単語を抜き出してください。"
    openai.api_key = "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"
    completions = openai.Completion.create(
        engine="text-davinci-003",
        prompt=prompt,
        max_tokens=1024,
        n=1,
        temperature=0.5,
    )

    text =  completions.choices[0].text
    lst = text.split("\n・")
    print(lst)
    print("make_image_words.py")
    return lst