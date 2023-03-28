import make_text
import pick_up_topics
import make_audio
import make_image_words
import make_image
import make_image2
import set_messages
import make_topic
import combine_image
import make_movie
import make_video
import make_topic_video
import test3

SLIDE_NUM = 3 # スライドの枚数
PROMPT =  "人間の構造"
#授業内容を作成
class_text = make_text.make_text(PROMPT)
# class_text = """
# 1. 2次関数の定義とグラフの形状
# 2次関数は、一般的にy=ax^2+bx+cの形で表されます。ここで、a、b、cは定数で、a≠0です。2次関数のグラフは、抛物線と呼ばれる曲線を描くもので、aの符号によって上に凸の抛物線か下に凸の抛物線かが決まります。xが増加すると、上に凸の抛物線になります。一方、xが減少すると、下に凸の抛物線になります。

# 2. パラメーターa、b、cによるグラフの形状の変化
# 2次関数のグラフの形状は、a、b、cそれぞれの定数の値によって変化します。まず、aの符号によって抛物線の形が上下反転します。aが正の場合は、下向きの抛物線になります。一方、aが負の場合は、上向きの抛物線になります。また、aの絶対値が大きいほど、曲線はよりくぼんでいきます。次に、bの符号によって抛物線の位置が左右に移動します。bが負の場合は、曲線が右に移動し、bが正の場合は、曲線が左に移動します。最後に、cの符号によって抛物線の位置が上下に移動します。cが正の場合は、曲線が上に移動し、cが負の場合は、曲線が下に移動します。

# 3. 頂点と軸の求め方
# 抛物線の頂点は、2次関数の式において、x=-b/2aとして求めることができます。これは、抛物線が対称なためです。このxの値を、2次関数の式に代入することで、頂点のy座標を求めることができます。したがって、頂点の座標は、(-b/2a,a(-b/2a)^2+b(-b/2a)+c)となります。また、抛物線の軸は、頂点を通る直線です。この軸は、2次関数の式の中央に位置するため、x=-b/2aで求めることができます。軸は、y軸と垂直になります。頂点を求めることによって、抛物線の最小値または最大値を求めることができます。
# """

# 音声をmake_audioに作成
make_audio.make_audio(class_text)

# # 画像をmake_imageに作成
# image_words = ["2次関数", "グラフ", "定義", "頂点", "切片", "傾き", "関数", "x軸", "y軸" ]

# for index, image_word in enumerate(image_words):
#     make_image.make_image(image_word, index + 1)
#     # make_image2.make_image(image_word, index + 1)


# make_imageの画像を背景と結合
combine_image.combine_img(class_text, SLIDE_NUM)

# 動画を作成
make_movie.make_movie(SLIDE_NUM)

# 動画と音声を結合
make_video.make_video()

# 目次の画像を作成
make_topic.make_topic(class_text)

# 目次を作成
topics = pick_up_topics.pick_up_topics(class_text)

# 目次の動画を作成
make_topic_video.make_topic_movie(SLIDE_NUM, topics)

# 全部くっつける
test3.clip()