#!/bin/bash

# This script downloads a video from YouTube and combines it with audio.

SAVE_DIR="/home/roman/Videos/YouTube"
mkdir -p "$SAVE_DIR"

# Ask the user for URL
echo "Enter URL: "
read url

# Find format code for the best resolution
# formats=$(yt-dlp -F $url --cookies-from-browser chromium:~/.var/app/org.chromium.Chromium)
formats=$(yt-dlp --cookies-from-browser firefox -F $url)

# Get the title of the video
# title=$(yt-dlp --get-title $url --cookies-from-browser chromium:~/.var/app/org.chromium.Chromium)
title=$(yt-dlp --cookies-from-browser firefox --get-title $url)

# Replace spaces with underscores and remove special characters for a valid file name
safe_title=$(echo "$title" | sed 's/[^[:alnum:]._-]/_/g')
output_file="${SAVE_DIR}/${safe_title}.mp4"

# Format codes
codes=(623 308 400 312 617)
descs=("1440p vp09" "1440p vp09 webm" "1440p av01" "1080p avc" "1080p vp09")

video_file=""
audio_file=""

for i in "${!codes[@]}"; do
  if [[ "$formats" == *"${codes[$i]}"* ]]; then
    echo "Format ${descs[$i]} found. Downloading video..."
    video_file="${SAVE_DIR}/video_temp.%(ext)s"
    if yt-dlp --cookies-from-browser firefox -f "${codes[$i]}" "$url" -o "$video_file"; then
      video_file=$(ls "${SAVE_DIR}/video_temp".*)
      echo "✅ Successfully downloaded format ${descs[$i]}"
      break
    else
      echo "❌ Failed to download format ${descs[$i]}, trying next..."
    fi
  fi
done
echo "Video downloaded."

echo "Downloading audio..."
# yt-dlp -f 140 "$url" -o "${SAVE_DIR}/audio_temp.%(ext)s" --cookies-from-browser chromium:~/.var/app/org.chromium.Chromium
audio_file="${SAVE_DIR}/audio_temp.%(ext)s"
yt-dlp --cookies-from-browser firefox -f bestaudio "$url" -o "$audio_file"
audio_file=$(ls "${SAVE_DIR}/audio_temp".*)
echo "Audio downloaded."

echo "Combining video and audio..."
if [[ -n "$video_file" && -n "$audio_file" ]]; then
  ffmpeg -i "$video_file" -i "$audio_file" -c:v copy -c:a aac "$output_file" -loglevel warning

  if [[ $? -eq 0 ]]; then
    echo "Combination complete. Saved as $output_file"
    echo "Cleaning up temp files..."
    rm -f "$video_file" "$audio_file"
    success=true
  else
    success=false
    echo "❌ ffmpeg failed. Temp files kept for debugging."
  fi
else
  success=false
  echo "❌ Failed to find downloaded video or audio file. Nothing combined."
fi

# Fallback if nothing worked
if [[ $success == false ]]; then
  echo "Falling back to best available video+audio..."
  yt-dlp --cookies-from-browser firefox -f "bv+ba/b" "$url" -o "$output_file"
  if [[ $? -eq 0 ]]; then
    echo "✅ Fallback download complete: $output_file"
  else
    echo "❌ All attempts failed."
  fi
fi
