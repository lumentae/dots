#!/usr/bin/env fish

# config
set MUSIC_DIR     "$HOME/Music/YoutubeMusic"
set ARCHIVE       "$MUSIC_DIR/downloaded.txt"
set NAVIDROME_DIR "/mnt/server/root/container/113/opt/navidrome/music/"
set GTA_DIR       "$HOME/.steam/steam/steamapps/compatdata/3240220/pfx/drive_c/users/steamuser/Documents/Rockstar Games/GTAV Enhanced/User Music/"
set COOKIE        "firefox:/home/lumentae/.zen/r2493afd.Default User/"

set PLAYLISTS \
    "https://www.youtube.com/playlist?list=LM" \
    "https://www.youtube.com/playlist?list=PL-GgbkABINgXHrEwEdLxUGu7Qx3lStaVQ"

# setup
mkdir -p "$MUSIC_DIR"

# download
echo "==> Downloading playlists..."

for url in $PLAYLISTS
    if [ "$argv[1]" != "--skip-download" ]
        echo "  -> $url"
        yt-dlp \
            -f bestaudio \
            --extract-audio \
            --audio-format opus \
            --audio-quality 0 \
            --cookies-from-browser "$COOKIE" \
            --embed-thumbnail \
            --convert-thumbnails jpg \
            --embed-metadata \
            --yes-playlist \
            --trim-filenames 200 \
            --sleep-interval 2 \
            --max-sleep-interval 5 \
            --download-archive "$ARCHIVE" \
            --replace-in-metadata "artist,album,title" "/" "-" \
            --replace-in-metadata "artist,album,title" "\"" ' ' \
            --output-na-placeholder Unknown \
            --match-filter "!is_live" \
            --ignore-errors \
            -o "$MUSIC_DIR/"'%(artist,uploader)s/%(album,webpage_url_domain)s/%(title).200s [%(id)s].%(ext)s' \
            "$url" 2>&1 | tee /tmp/ytdlp-log.txt

        grep "Video unavailable|Terms of Service|Community Guidelines" /tmp/ytdlp-log.txt | while read -l line
            set id (string match -r '\[youtube\] ([A-Za-z0-9_-]+):' $line | tail -1)
            if test -n "$id"
                if not grep -q "$id" "$ARCHIVE"
                    echo "youtube $id" >> "$ARCHIVE"
                    echo (set_color brred)"  archived unavailable: $id"(set_color normal)
                end
            end
        end
    else
        echo "  skipping: $url"
    end
end

echo "==> Exporting playlist structure"
for url in $PLAYLISTS
    echo "  -> $url"

    set playlist_id (string match -r 'list=([^&]+)' $url | tail -1)

    yt-dlp \
        --cookies-from-browser "$COOKIE" \
        --yes-playlist \
        --flat-playlist \
        --dump-json \
        "$url" \
        > /tmp/$playlist_id.json

    echo "#EXTM3U" > "$MUSIC_DIR/$playlist_id.m3u"

    # i should definitly make this more performant...
    while read -l id
        set match (find "$MUSIC_DIR" -name "*\[$id\]*" | head -1)
        if test -n "$match"
            set relative (string replace "$MUSIC_DIR/" "" $match)
            echo $relative >> "$MUSIC_DIR/$playlist_id.m3u"
        end
    end < (python3 -c "
    import sys, json
    for line in open('/tmp/$playlist_id.json'):
        try:
            print(json.loads(line)['id'])
        except:
            pass
    " | psub)

    echo (set_color green)"  -> wrote $MUSIC_DIR/$playlist_id.m3u"(set_color normal)
end

# sync to navidrome
echo "==> Syncing opus files to Navidrome..."
rsync -av --progress \
    --include="*/" \
    --include="*.opus" \
    --include="*.m3u" \
    --exclude="*" \
    "$MUSIC_DIR/" \
    "$NAVIDROME_DIR"

# generate mp3s
find $MUSIC_DIR -name "*.opus" | parallel -j12 \
    ffmpeg -i {} -c:a libmp3lame -q:a 2 -map_metadata 0 {.}.mp3

# symlink mp3s for gta
echo "==> Linking MP3s to GTA V Enhanced Self Radio..."
mkdir -p "$GTA_DIR"

find "$MUSIC_DIR" -name "*.mp3" | while read -l mp3
    set link "$GTA_DIR/"(basename "$mp3")
    if not test -L "$link"
        ln -s "$mp3" "$link"
        echo "  linked: "(basename "$mp3")
    end
end

echo "==> Done."