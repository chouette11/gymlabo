import os
from enum import Enum
import openai

def make_text(prompt):
    # タグの生成
    openai.api_key = "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"
    response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
            {"role": "system", "content": "あなたは優秀な教師です。"},
            {"role": "user", "content": prompt + "についての授業のカリキュラムを構成してください。"},
        ]
    )
    cal = response["choices"][0]["message"]["content"]
    response2 = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
            {"role": "system", "content": "あなたは優秀な教師です。"},
            {"role": "user", "content": prompt + "についての授業のカリキュラムを構成してください。"},
            {"role": "assistant", "content": cal},
            {"role": "user", "content": "上記のカリキュラムの1から3を順番に詳しく説明してください。"},
        ],
    )
    cal = response2["choices"][0]["message"]["content"]
    response3 = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
            {"role": "system", "content": "あなたは優秀な教師です。見出しはカギカッコで囲んでください"},
            {"role": "user", "content": cal + "\n上記のカリキュラムの1から3を順番に詳しく具体的に説明してください。"},
        ],
    )
    print(response["choices"][0]["message"]["content"])
    print(response2["choices"][0]["message"]["content"])
    print(response3["choices"][0]["message"]["content"])
    print("make_text.py")
    return response3["choices"][0]["message"]["content"]

if __name__ == "__main__":
    prompt = "2次関数についての授業のカリキュラムを構成してください。"
    make_text(prompt)