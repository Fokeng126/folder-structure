#!/usr/bin/env bash

# Enable safer Bash behaviour.
set -uo pipefail

folder="${1:-.}"

if [[ ! -d "$folder" ]]; then
    printf "Error: Directory '%s' does not exist.\n" "$folder" >&2
    exit 1
fi

printf "Organising %s...\n" "$folder"

moved_count=0

shopt -s nullglob dotglob

for filepath in "$folder"/*; do

    if [[ ! -f "$filepath" ]]; then
        continue
    fi

    filename="${filepath##*/}"

    case "$filename" in
    organiser.sh | README.md | Readme.md)
        continue
        ;;
    esac

    ext="${filename##*.}"

    if [[ "$filename" != *.* || "$filename" == .* && "$filename" != *.*.* ]]; then
        ext=""
    else
        ext="${ext,,}"
    fi

    case "$ext" in
    jpg | jpeg | png | gif | webp)
        category="Pictures"
        ;;
    pdf | doc | docx | txt | xlsx | pptx)
        category="Documents"
        ;;
    mp3 | wav | m4a)
        category="Audio"
        ;;
    mp4 | mkv | mov)
        category="Video"
        ;;
    zip | rar | tar | gz)
        category="Archives"
        ;;
    *)
        category="Other"
        ;;
    esac

    dest_dir="$folder/$category"

    if ! mkdir -p -- "$dest_dir"; then
        printf "Error: Could not create '%s'.\n" "$dest_dir" >&2
        continue
    fi

    final_name="$filename"
    counter=1

    while [[ -e "$dest_dir/$final_name" || -L "$dest_dir/$final_name" ]]; do

        if [[ -n "$ext" ]]; then
            base="${filename%.*}"
            original_ext="${filename##*.}"
            final_name="${base}(${counter}).${original_ext}"
        else
            final_name="${filename}(${counter})"
        fi

        ((counter += 1))
    done

    if mv -- "$filepath" "$dest_dir/$final_name"; then

        printf '%s\n' "====================================="
        printf "Moved '%s' to '%s'\n" "$filename" "$dest_dir/$final_name"
        printf '%s\n' "====================================="

        ((moved_count += 1))
    else
        printf "Error: Could not move '%s'.\n" "$filename" >&2
    fi

done

printf "\nTidying complete! Total files moved: %d\n" "$moved_count"
