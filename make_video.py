from moviepy.editor import VideoFileClip, AudioFileClip

def make_video():
    video_file = "./movie/movie.mp4"
    audio_file = "./make_audio/hello_world.mp3"
    output_file = "./video/test_video.mp4"

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