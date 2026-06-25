function get-album --wraps='yt-dlp -o "%(playlist_index)s. %(title)s.%(ext)s" --embed-thumbnail --embed-chapters --embed-metadata -x -t mp3' --description 'alias get-album=yt-dlp -o "%(playlist_index)s. %(title)s.%(ext)s" --embed-thumbnail --embed-chapters --embed-metadata -x -t mp3'
    yt-dlp -o "%(playlist_index)s. %(title)s.%(ext)s" --embed-thumbnail --embed-chapters --embed-metadata -x -t mp3 $argv
end
