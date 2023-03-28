import re

# 正規表現によるパターンマッチング
pattern = r'[\d]+\.'
text1 = "3. 頂点と軸の求め方"
text2 = "This string does not contain any numbers."
match1 = re.search(pattern, text1)
match2 = re.search(pattern, text2)

# マッチング結果の取得
if match1:
    print("Match found in text1:", match1.group())
else:
    print("Match not found in text1.")
    
if match2:
    print("Match found in text2:", match2.group())
else:
    print("Match not found in text2.")