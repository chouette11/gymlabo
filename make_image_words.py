from enum import Enum
import openai


def make_image_words(prompt, class_text):
    # タグの生成
    openai.api_key = "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"
    response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
            {"role": "system", "content": "あなたは優秀な教師です。"},
            {"role": "user", "content": prompt + "について理解するために重要な用語を10文字以上で３つ抜き出してください"},
        ]
    )
    print(response["choices"][0]["message"]["content"])
    print("make_text.py")
    return response["choices"][0]["message"]["content"]

if __name__ == "__main__":
    class_text = """
1. 「生命体の特徴と種類について」
Match found in text1: 1.
このカリキュラムでは、生命体について学びます
生命体は、自己維持、自己調整、適応、増殖、変異、進化などの特徴を持ちます
これらの特徴があることで、生命体は周囲の環境に対して生存していくことができます
また、生物は、門、綱、目、科、属、種などの分類方法によって分類されています
生物の形態、機能、進化の観点から分けられ、ある程度互換性があるもの同士がグループ化されています


2. 「細胞と細胞の構成要素について」
Match found in text1: 2.
このカリキュラムでは、生物の基本単位である細胞について学びます
細胞には、細胞膜、細胞壁、核、ミトコンドリア、小胞体、ゴルジ体、リボソームなどの構成要素があります
これらの細胞の構成要素は、それぞれ細胞の機能に応じて役割を果たしています
真核生物には、動物細胞、植物細胞、菌類細胞などがあり、原核生物には細菌が含まれます
一方、生物の進化は細胞の進化から始まったため、全ての生命体にとって細胞が基本的な単位となります


3. 「組織について」
Match found in text1: 3.
このカリキュラムでは、細胞が集まって形成される組織について学びます
組織には、上皮組織、結合組織、筋肉組織、神経組織などがあります
それぞれの種類の組織は、身体の各種の部分に存在し、それぞれの機能に応じて役割を果たします
例えば、上皮組織は、皮膚や粘膜などの表面を覆っています
組織が集まって形成された器官は、各種の機能を持ちます
例えば、心臓や肝臓などの臓器があります
これらの器官は、単なる細胞や組織よりも複雑な機能を持ち、生命維持に重要な役割を果たします"""
    make_image_words("人間の構造", class_text)