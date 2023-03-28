from fontTools import ttLib
import os

font_paths = ['/System/Library/Fonts', '/Library/Fonts']

fonts = []

for font_path in font_paths:
    font_names = os.listdir(font_path)
    for font_name in font_names:
        font_file = os.path.join(font_path, font_name)
        try:
            font = ttLib.TTFont(font_file)
            font_name = font['name'].getName(1, 3, 1, 1033).toUnicode()
            fonts.append((font_name, font_file))
        except:
            pass

print(fonts)