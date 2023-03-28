from moviepy.editor import *
import cv2
import glob
import moviepy.editor as mp
from pydub import AudioSegment
import numpy

def clip():
    clip1 = VideoFileClip("./video/topic_video.mp4")
    clip2 = VideoFileClip("./video/video.mp4")

    # 2つ以上も連結できます
    clip = concatenate_videoclips([clip1, clip2])
    clip.write_videofile("concatenate.mp4")


    # ファイル名
    input_folder = "./video"#読み込む動画があるフォルダ
    image_out = "image_out.mp4"#映像のみの出力
    sound_out = "sound_out.mp3"#音声のみの出力
    movie_out = "movie_out.mp4"#映像と音声の出力

    #元の動画を結合し音声なしで出力
    def comb_movie(movies_in, image_out):

        # 形式はmp4
        fourcc = cv2.VideoWriter_fourcc('m','p','4','v')

        # 動画情報の取得
        movie = cv2.VideoCapture(movies_in[0])
        fps = movie.get(cv2.CAP_PROP_FPS)
        height = movie.get(cv2.CAP_PROP_FRAME_HEIGHT)
        width = movie.get(cv2.CAP_PROP_FRAME_WIDTH)


        # 出力先のファイルを開く
        out = cv2.VideoWriter(image_out, int(fourcc), fps, (int(width), int(height)))

        for movie_in in movies_in:
            # 動画ファイルの読み込み，引数はビデオファイルのパス
            movie = cv2.VideoCapture(movie_in)

            # 正常に動画ファイルを読み込めたか確認
            if movie.isOpened() == True: 
                # read():1コマ分のキャプチャ画像データを読み込む
                ret, frame = movie.read()
            else:
                ret = False
                print(movie_in + "：読み込めませんでした")
                
            while ret:
                # 読み込んだフレームを書き込み
                out.write(frame)
                # 次のフレーム読み込み
                ret, frame = movie.read()

            print(movie_in)

    #元の動画の音声を結合し映像のみの動画に付加
    def set_audio(movies_in, movie_out, image_out, sound_out):

        sound = None

        #元のファイルから音声を一つずつ抽出して結合
        for movie_in in movies_in:
            if sound == None:
                sound = AudioSegment.from_file(movie_in,"mp4")
            else:
                sound += AudioSegment.from_file(movie_in,"mp4")
                
        #結合した音声を出力
        sound.export(sound_out, format="mp3")

    #フォルダ内のmp4ファイルを名前順でソート
    movies_in = sorted(glob.glob(input_folder + "/*.mp4"))

    comb_movie(movies_in, image_out)

    set_audio(movies_in, movie_out, image_out, sound_out)


    video_file = "concatenate.mp4"
    audio_file = "sound_out.mp3"
    output_file = "output.mp4"

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