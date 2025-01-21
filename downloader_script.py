import yt_dlp

def Download(link):
    ydl_opts = {
        'format': 'best',
        'outtmpl': '%(title)s.%(ext)s',  # Save file with video title as filename
    }
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            ydl.download([link])
        print("Download completed successfully!")
    except Exception as e:
        print("An error occurred:", e)

if __name__ == "__main__":
    link = input("Enter the YouTube video URL: ")
    Download(link)
