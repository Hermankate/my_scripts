import yt_dlp

def download_video(link, save_path):
    ydl_opts = {'outtmpl': save_path}
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            ydl.download([link])
        return f"Video saved at {save_path}"
    except Exception as e:
        return f"An error occurred: {e}"
