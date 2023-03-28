import re
class_text = """
1. 2次関数の定義とグラフの形状
2次関数は、一般的にy=ax^2+bx+cの形で表されます。ここで、a、b、cは定数で、a≠0です。2次関数のグラフは、抛物線と呼ばれる曲線を描くもので、aの符号によって上に凸の抛物線か下に凸の抛物線かが決まります。xが増加すると、上に凸の抛物線になります。一方、xが減少すると、下に凸の抛物線になります。

2. パラメーターa、b、cによるグラフの形状の変化
2次関数のグラフの形状は、a、b、cそれぞれの定数の値によって変化します。まず、aの符号によって抛物線の形が上下反転します。aが正の場合は、下向きの抛物線になります。一方、aが負の場合は、上向きの抛物線になります。また、aの絶対値が大きいほど、曲線はよりくぼんでいきます。次に、bの符号によって抛物線の位置が左右に移動します。bが負の場合は、曲線が右に移動し、bが正の場合は、曲線が左に移動します。最後に、cの符号によって抛物線の位置が上下に移動します。cが正の場合は、曲線が上に移動し、cが負の場合は、曲線が下に移動します。

3. 頂点と軸の求め方
抛物線の頂点は、2次関数の式において、x=-b/2aとして求めることができます。これは、抛物線が対称なためです。このxの値を、2次関数の式に代入することで、頂点のy座標を求めることができます。したがって、頂点の座標は、(-b/2a,a(-b/2a)^2+b(-b/2a)+c)となります。また、抛物線の軸は、頂点を通る直線です。この軸は、2次関数の式の中央に位置するため、x=-b/2aで求めることができます。軸は、y軸と垂直になります。頂点を求めることによって、抛物線の最小値または最大値を求めることができます。
"""
class_text = class_text.replace("。", "\n")
l = class_text.split("\n")

sentences = class_text.split("\n")  

# 目次一覧
topics = []
for sentence in sentences:
    print(sentence)

    # 正規表現によるパターンマッチング
    pattern = r'[\d]+\.'
    pattern2 = r":[^:\n]*:|：[^:\n]*："
    match1 = re.search(pattern, sentence)
    match2 = re.search(pattern2, sentence)

    # マッチング結果の取得
    if match1 or match2:
        topics.append(sentence)
        print("Match found in text1:", match1.group())
        
print(topics)
