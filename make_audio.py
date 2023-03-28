from gtts import gTTS
from pydub import AudioSegment

def make_audio(title):
    # テキストから音声を生成する
    tts = gTTS(title, lang='ja')

    # 音声を保存する
    tts.save('./make_audio/hello_world.mp3')

    print("make_audio.py")

