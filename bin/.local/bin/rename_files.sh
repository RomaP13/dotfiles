#!/bin/bash

# Ask for the directory and the new file name
echo "Enter the directory:"
read directory
echo "Enter the new file name (without extension):"
read newname

# Initialize a counter
counter=1

# Change to the specified directory
cd "$directory"

# Loop over all files in the current directory
for file in *; do
    # Get the extension of the file
    extension="${file##*.}"
    
    # Rename the file
    mv "$file" "$newname($counter).$extension"
    
    # Increment the counter
    ((counter++))
done
