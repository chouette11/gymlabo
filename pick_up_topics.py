import re
# 本文から目次を抽出
def pick_up_topics(class_text):

        # 本文を一行ずつに分割
    class_text = class_text.replace("。", "\n")
    sentences = class_text.split("\n")  

    # 目次一覧
    topics = []
    for sentence in sentences:
        print(sentence)

        # 正規表現によるパターンマッチング
        pattern = r'[\d]+\.'
        match1 = re.search(pattern, sentence)

        # マッチング結果の取得
        if match1:
            topics.append(sentence)
            print("Match found in text1:", match1.group())
            
    return topics