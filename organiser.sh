#!/bin/bash

echo "Hey there! Am working on a script to organise your files into folders based on their file types. This script will help you keep your directories neat and tidy."

# 1. Choosing folder to be organised
if [ -z "$1" ]; then
    folder="."
else
    folder="$1"
fi

# 2. Show the starting message
echo "Organising $folder..."

# 3. Check if the folder does NOT exist
if [ ! -f "$folder" ]; then
    echo "Error: Directory '$folder' does not exist." >&2
    exit 1
fi

# 4. Initialize a counter for all moved files
moved_count=0

# 5. Look at every item in the folder one by one
for filepath in "$folder"/*; do 
    # Only touch it if it's a real file (ignore folders)
    if [ -f "$filepath" ]; then 
        # Grab just the name of the file (e.g., photo.JPG)
        filename=$(basename "$filepath") 

        # complete fix Skip the script and the readme so they don't move into 'Other'
        if [ "$filename" = "organiser.sh" ] || [ "$filename" = "Readme.md" ] || [ "$filename" = "README.md" ]; then
            continue
        fi

        # Extract the extension and force it to lowercase
        ext="${filename##*.}"
        ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

        # If the file has no dot at all, treat its extension as empty
        if [[ "$filename" != *.* ]]; then
            ext=""
        fi

        # Find the right category folder name
        case "$ext" in
            jpg|jpeg|png|gif|webp) category="Pictures" ;;
            pdf|doc|docx|txt|xlsx|pptx) category="Documents" ;;
            mp3|wav|m4a) category="Audio" ;;
            mp4|mkv|mov) category="Video" ;;
            zip|rar|tar|gz) category="Archives" ;;
            *) category="Other" ;;
        esac

        # 6. Setting up a path for the category folder
        dest_dir="$folder/$category"

        # 7. Creating the folder ONLY if it does NOT exist yet
        if [ ! -d "$dest_dir" ]; then
            mkdir -p "$dest_dir"
        fi

        # Filename without extension
        base="${filename%.*}"
        final_name="$filename"
        counter=1

        # 8. Check if the file already exists in the destination folder 
        # If it does, keep adding a number until we find a free spot!
        while [ -f "$dest_dir/$final_name" ]; do
            if [ -n "$ext" ]; then
                final_name="${base}($counter).$ext"
            else
                final_name="${base}($counter)"
            fi
            counter=$((counter + 1))
        done

        # Safe to move now!
        mv "$filepath" "$dest_dir/$final_name"
        echo =====================================
        echo "Moved '$filename' to '$dest_dir/$final_name'"
        echo =====================================
        ((moved_count++))
    fi
done

echo "Tidying complete! Total files moved good job: $moved_count"

