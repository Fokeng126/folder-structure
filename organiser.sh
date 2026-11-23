
#!/bin/bash

# 1. Choose the folder to organise
if [ -z "$1" ]; then
  folder="."
else
  folder="$1"
fi

# 2. Check if the folder exists
if [ ! -d "$folder" ]; then
  echo "Error: Directory '$folder' does not exist." >&2
  exit 1
fi

# 3. Initialise a counter for moved files
moved_count=0

# 4. Look at every item in the folder
for filepath in "$folder"/*; do

  # Only organise files, not folders
  if [ -f "$filepath" ]; then

    # Get the file name
    filename=$(basename "$filepath")

    # Skip the organiser script and README files
    if [ "$filename" = "organiser.sh" ] || [ "$filename" = "README.md" ] || [ "$filename" = "Readme.md" ]; then
      continue
    fi

    # 5. Extract the original extension
    original_ext="${filename##*.}"

    # Convert extension to lowercase for category matching
    ext=$(printf '%s' "$original_ext" | tr '[:upper:]' '[:lower:]')

    # Handle files without an extension
    if [[ "$filename" != *.* ]]; then
      original_ext=""
      ext=""
    fi

    # 6. Choose a category based on the extension
    case "$ext" in
      jpg | jpeg | png | gif | webp) category="Images" ;;
      pdf | doc | docx | txt | xlsx | pptx) category="Documents" ;;
      mp3 | wav | m4a) category="Audio" ;;
      mp4 | mkv | mov) category="Video" ;;
      zip | rar | tar | gz) category="Archives" ;;
      *) category="Other" ;;
    esac

    # 7. Create the destination folder
    dest_dir="$folder/$category"
    mkdir -p "$dest_dir"

    # 8. Prepare the new file name
    base="${filename%.*}"
    final_name="$filename"
    counter=1

    # 9. Check if a file with the same name already exists
    while [ -f "$dest_dir/$final_name" ]; do
      if [ -n "$original_ext" ]; then
        final_name="${base}($counter).${original_ext}"
      else
        final_name="${base}($counter)"
      fi

      counter=$((counter + 1))
    done

    # 10. Move the file and display the result
    if mv "$filepath" "$dest_dir/$final_name"; then
      echo "$filename -> $category/"
      moved_count=$((moved_count + 1))
    else
      echo "Error: Could not move $filename." >&2
      exit 1
    fi

  fi
done

# 11. Display the final summary
echo "Total files moved: $moved_count"
