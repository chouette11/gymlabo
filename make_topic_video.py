import os
import cv2
import numpy as np
from pydub import AudioSegment
from gtts import gTTS
from pydub import AudioSegment
from moviepy.editor import VideoFileClip, AudioFileClip

def make_topic_movie(slide_num, topics):
    # 動画用の画像作成
    text = "まずは目次です。"
    for topic in topics:
        text = text + topic 
    text += "以上3つについて説明していきます。"
    
    # テキストから音声を生成する
    tts = gTTS(text, lang='ja')

    # 音声を保存する
    tts.save('./make_audio/topic.mp3')

    print("make_audio.py")

    # 音声ファイルを読み込み
    audio = AudioSegment.from_file('./make_audio/topic.mp3')

    # 長さを取得（単位はミリ秒）
    length = len(audio) / 1000

    fps = (slide_num - 1) * 100 / length 

    outimg_files = []
    for j in range(0, int(400)):
        outimg_files.append('topic/image.jpg')

    # 動画作成
    fourcc = cv2.VideoWriter_fourcc('m','p','4', 'v')
    video  = cv2.VideoWriter('./movie/topic_movie.mp4', fourcc, fps, (1920, 1080))

    for img_file in outimg_files:
        img = cv2.imread(img_file)
        video.write(img)

    video.release()

    video_file = "./movie/topic_movie.mp4"
    audio_file = "./make_audio/topic.mp3"
    output_file = "./video/topic_video.mp4"

    # 動画ファイルを読み込む
    video_clip = VideoFileClip(video_file)

    # 音声ファイルを読み込む
    audio_clip = AudioFileClip(audio_file)

    # 動画ファイルに音声を追加する
    final_clip = video_clip.set_audio(audio_clip)

    # 結果をファイルに保存する
    final_clip.write_videofile(output_file, codec='libx264', audio_codec='aac')

    # メモリを解放する
    video_clip.close()
    audio_clip.close()
    final_clip.close()