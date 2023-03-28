import PIL.Image
import PIL.ImageDraw
import PIL.ImageFont

def make_telop(text, index):
    # 息継ぎの追加
    text = text + "。"
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
    textWidth, textHeight = draw.textsize(text,font=font)
    textTopLeft = (16, canvasSize[1]//2-textHeight//2) # 前から1/6，上下中央に配置
    draw.text(textTopLeft, text, fill=textRGB, font=font)

    img.save("./telop/image" + str(index) + ".png")
