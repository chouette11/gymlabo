import re
import pick_up_topics
import cv2
import PIL.Image
import PIL.ImageDraw
import PIL.ImageFont

def make_topic(class_text):
    # 本文から目次を抽出 
    topics = pick_up_topics.pick_up_topics(class_text)

    # 目次を画像に変換
    for index, topic in enumerate(topics):
        # 使うフォント，サイズ，描くテキストの設定
        ttfontname = '/Library/Fonts/Arial Unicode.ttf'
        fontsize = 36

        # 画像サイズ，背景色，フォントの色を設定
        canvasSize    = (1000, 150)
        backgroundRGB = (0, 0, 0)
        textRGB       = (255, 255, 255)

        # 文字を描く画像の作成
        img  = PIL.Image.new('RGB', canvasSize, backgroundRGB)
        draw = PIL.ImageDraw.Draw(img)

        # 用意した画像に文字列を描く
        font = PIL.ImageFont.truetype(ttfontname, fontsize)
        textWidth, textHeight = draw.textsize(topic,font=font)
        textTopLeft = (16, canvasSize[1]//2-textHeight//2) # 前から1/6，上下中央に配置
        draw.text(textTopLeft, topic, fill=textRGB, font=font)

        img.save("./topic/image" + str(index) + ".jpg")

    # 画像を結合
    img1 = cv2.imread('./make_img/background.png')
    img2 = cv2.imread('./topic/image' + str(0) +'.jpg')
    img3 = cv2.imread('./topic/image' + str(1) + '.jpg')
    img4 = cv2.imread('./topic/image' + str(2) + '.jpg')

    large_img = img1
    small_img = img2
    smail_img2 = img3
    small_img3 = img4

    x_offset1=0
    y_offset1=0

    x_offset2=0
    y_offset2=50

    x_offset3=0
    y_offset3=100

    large_img[y_offset1:y_offset1+small_img.shape[0], x_offset1:x_offset1+small_img.shape[1]] = small_img

    large_img[y_offset2:y_offset2+smail_img2.shape[0], x_offset2:x_offset2+smail_img2.shape[1]] = smail_img2

    large_img[y_offset3:y_offset3+small_img3.shape[0], x_offset3:x_offset3+small_img3.shape[1]] = small_img3 

    cv2.imwrite('make_img/image0.jpg', large_img)
 


