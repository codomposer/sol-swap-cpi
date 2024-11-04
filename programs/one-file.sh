#!/bin/bash

# Check if a root folder is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <output_file> <root_folder>"
    exit 1
fi

# Output file name (first argument)
output_file="$1"

# Root folder (second argument)
root_folder="$2"

# Check if the root folder exists
if [ ! -d "$root_folder" ]; then
    echo "Error: The specified root folder does not exist."
    exit 1
fi

# Function to process files
process_file() {
    local file="$1"
    local relative_path="${file#$root_folder/}"
    
    echo "PATH=${relative_path}" >> "$output_file"
    cat "$file" >> "$output_file"
    echo "" >> "$output_file"  # Add a line break after each file
}

# Clear or create the output file
> "$output_file"

# Find all files, excluding hidden files and directories
find "$root_folder" -type f -not -path '*/\.*' | while read -r file; do
    process_file "$file"
done

echo "All files have been concatenated into $output_file"
