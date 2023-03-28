import os
import cv2
import numpy as np
from pydub import AudioSegment

def make_movie(slide_num):
    # 動画用の画像作成
    outimg_files = []
    for i in range(0, slide_num - 1):
        for j in range(0, 100):
            outimg_files.append('combine_img/combine' + str(i) + "_" + str(j) + '.jpg')

    # 音声ファイルを読み込み
    audio = AudioSegment.from_file('./make_audio/hello_world.mp3')

    # 長さを取得（単位はミリ秒）
    length = len(audio) / 1000

    fps = (slide_num - 1) * 100 / length 

    # 動画作成
    fourcc = cv2.VideoWriter_fourcc('m','p','4', 'v')
    video  = cv2.VideoWriter('./movie/movie.mp4', fourcc, fps, (1920, 1080))

    for img_file in outimg_files:
        img = cv2.imread(img_file)
        video.write(img)

    video.release()