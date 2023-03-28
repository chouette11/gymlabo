import cv2
import set_messages
from PIL import Image, ImageFont, ImageDraw
import numpy as np
from pydub import AudioSegment
import make_telop

def combine_img(class_text, slide_num):
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
    
    for i in range(0, (slide_num - 1) * 2 , 2):
        img1 = cv2.imread('./make_img/background.png')
        print(i)
        img2 = cv2.imread('./make_img/image' + str(i) +'.jpg')
        img3 = cv2.imread('./make_img/image' + str(i+1) + '.jpg')

        large_img = img1
        small_img = img2
        smail_img2 = img3

        x_offset1=320
        y_offset1=180

        x_offset2=1920 - 320 - 512
        y_offset2=180

        large_img[y_offset1:y_offset1+small_img.shape[0], x_offset1:x_offset1+small_img.shape[1]] = small_img

        large_img[y_offset2:y_offset2+smail_img2.shape[0], x_offset2:x_offset2+smail_img2.shape[1]] = smail_img2

        # テロップの合成

        # テロップの文章を取得
        messages = set_messages(class_text, slide_num)

        # フレームを100倍にし、テロップの挿入
        for j in range(0, 100):
            index = j + int(i/2) * 100 
            for message in messages:
                if (index > message[1] and index < message[2]):
                    img4 = cv2.imread('./telop/image' + str(message[0]) + '.png')
                    smail_img3 = img4
                    x_offset3= int((1920 - 1000) / 2)
                    y_offset3= 800
                    large_img[y_offset3:y_offset3+smail_img3.shape[0], x_offset3:x_offset3+smail_img3.shape[1]] = smail_img3

            cv2.imwrite('combine_img/combine' + str(int(i/2)) + "_" + str(j) + '.jpg', large_img)
            
if __name__ == '__main__':
    combine_img(5)