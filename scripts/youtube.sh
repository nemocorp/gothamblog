ffmpeg -y -loop 1 -r 1 -i $1 -acodec copy -i $2 -shortest music-video.mp4
