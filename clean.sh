#!/bin/zsh

rootPath=$(pwd)

echo "🔍 Searching for all 'bin' and 'obj' folders under: \"$rootPath\" ..."

# Use `find` to get absolute paths to bin and obj folders
foldersToDelete=()
while IFS= read -r -d $'\0' folder; do
  foldersToDelete+=("$folder")
done < <(find "$rootPath" \( -name bin -o -name obj \) -type d -print0)

if (( ${#foldersToDelete[@]} == 0 )); then
  echo "✅ No 'bin' or 'obj' folders found."
  exit 0
fi

echo "🧹 Found ${#foldersToDelete[@]} folders to delete."

for folder in "${foldersToDelete[@]}"; do
  echo "🗑️ Deleting folder: $folder"
  rm -rf "$folder"
  if [[ ! -d "$folder" ]]; then
    echo "✔️ Deleted: $folder"
  else
    echo "❌ Failed to delete: $folder"
  fi
done

echo "✅ Cleanup complete."
