import cv2
from PIL import Image, ImageFont, ImageDraw
import numpy as np
import os
from pydub import AudioSegment
import make_telop

def set_messages(class_text, slide_num):
    # 音声ファイルを読み込み
    audio = AudioSegment.from_file('./make_audio/hello_world.mp3')

    # 長さを取得（単位秒）
    length = len(audio) / 1000

    # 一文字あたりの時間
    spc = length / len(class_text)
    sum_time = 0
    fps = slide_num * 100 / length
    message = []                # テロップ文章と時間の配列

    # 本文を一行ずつに分割
    class_text = class_text.replace("。", "\n")
    sentences = class_text.split("\n")    

    for i in range(len(sentences)):
        # テロップの画像を作成
        make_telop.make_telop(sentences[i], i)

        # テロップ文章と時間の配列を作成
        time = spc * len(sentences[i])
        message.append([i, sum_time * fps, (sum_time + time) * fps, sentences[i]])
        sum_time = sum_time + time + 0.4

    return message