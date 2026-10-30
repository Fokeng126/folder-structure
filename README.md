# File Organizer Script

This is a simple tool that cleans up cluttered folders by automatically moving files into neat category folders based on what type of file they are.

## What it does

- **Groups files into folders**: It sorts your files into folders like Pictures, Documents, Audio, and Video.
- **Does not overwrite files**: If a file with the same name already exists in the new folder, it adds a number to it (like `photo(1).jpg`) so you don't lose anything.
- **Cleans up spaces**: It automatically fixes spaces in filenames by turning them into underscores (`_`) so they work better in terminal systems.

## Where your files go

The script looks at the end of your file name (the extension) and sorts them into these folders:

- **Pictures**: `jpg`, `jpeg`, `png`, `gif`, `webp`
- **Documents**: `pdf`, `doc`, `docx`, `txt`, `xlsx`, `pptx`
- **Audio**: `mp3`, `wav`, `m4a`
- **Video**: `mp4`, `mkv`, `mov`
- **Archives**: `zip`, `rar`, `tar`, `gz`
- **Other**: Anything else that doesn't fit the lists above.

---

## How to use it

### Step 1: Give it permission to run
Before using it the first time, open your terminal and type this command to let the script run:
```bash
chmod +x organiser.sh
```

### Step 2: Run it

**Option A: Clean up the folder you are currently in**
Just type this command:
```bash
./organiser.sh
```

**Option B: Clean up a specific folder somewhere else**
Type the command followed by the path to that folder:
```bash
./organiser.sh /path/to/your/cluttered/folder
```

When it finishes, the script will show you a nice summary message telling you exactly how many files it moved!
