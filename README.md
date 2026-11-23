# File Organizer Script

## Problem Statement

Keeping files in one folder can make it difficult to find documents, images, audio, and videos. When many files are stored together, the folder becomes disorganised and difficult to manage.

## Project Goal

The goal of this project is to create a Bash script that automatically organises files into different folders based on their file extensions. This helps keep files organised and makes them easier to find.

## Tech Stack

- Bash
- Linux Terminal
- Git and GitHub
- Visual Studio Code

## Screenshots

Screenshots of the script running and the organised folders will be added here.

## Features

- Automatically moves files into folders based on their file extensions.
- Sorts files into Images, Documents, Audio, Video, Archives, and Other.
- Recognises uppercase and lowercase file extensions.
- Preserves spaces in filenames.
- Prevents files from being overwritten by adding a number to duplicate filenames.
- Preserves the original extension case when renaming duplicate files.
- Displays each file moved and the total number of files moved.
- Shows an error message if the selected directory does not exist.

## Installation and Setup

### Step 1: Clone the repository

Run this command to download the project:

```bash
git clone https://github.com/Fokeng126/folder-structure.git
```

### Step 2: Enter the project folder

```bash
cd folder-structure
```

### Step 3: Give the script permission to run

```bash
chmod +x organiser.sh
```

### Step 4: Run the script

To organise files in the current directory:

```bash
./organiser.sh
```

To organise files in another directory:

```bash
./organiser.sh /path/to/your/folder
```

**Note:** The script moves files, so it is safer to test it using a copy of your folder first.

## Challenges Faced

- Handling uppercase and lowercase file extensions.
- Preventing files with the same name from being overwritten.
- Preserving spaces in filenames.
- Making sure files are moved into the correct category folders.
- Testing the script with different types of files.

## What I Learnt

- How to use Bash variables, loops, conditions, and case statements.
- How to work with files and directories using Linux commands.
- How to use `mkdir` and `mv` in Bash scripts.
- How to handle filenames containing spaces.
- How to test and debug a Bash script.
- How to use Git and GitHub to manage project changes.

## Author

**Joshua Kroos**