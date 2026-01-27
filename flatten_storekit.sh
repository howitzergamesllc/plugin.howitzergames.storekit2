#!/bin/bash
set -e

# Paths
SWIFT_SRC="$HOME/Visual Studio Projects/Maui.InAppBilling/maui.storekit2.apple/swift/StoreKit2-swift/StoreKit2.xcframework"
EXTERNALS_DIR="$HOME/Visual Studio Projects/Maui.InAppBilling/maui.storekit2.apple/externals"
DEST="$EXTERNALS_DIR/StoreKit2.xcframework"

echo "Copying StoreKit2.xcframework from Swift folder to externals..."
cp -R "$SWIFT_SRC" "$DEST"
echo "Copy complete: $DEST"

echo "Starting to flatten Mac Catalyst .xcframework symlinks in $DEST..."

# Flatten Versions folder first (handle Current symlink)
find "$DEST" -type d -name "Versions" | while read -r VERSIONS_DIR; do
    echo "Processing Versions folder: $VERSIONS_DIR"
    CURRENT_LINK="$VERSIONS_DIR/Current"

    if [ -L "$CURRENT_LINK" ]; then
        TARGET_DIR=$(readlink "$CURRENT_LINK")
        ABS_TARGET_DIR=$(realpath "$VERSIONS_DIR/$TARGET_DIR")

        echo "Replacing Current symlink with real copy: $ABS_TARGET_DIR"
        rm "$CURRENT_LINK"
        cp -R "$ABS_TARGET_DIR" "$VERSIONS_DIR/Current"
    fi
done

# Flatten all remaining symlinks recursively
find "$DEST" -type l | while read -r SYMLINK; do
    TARGET=$(readlink "$SYMLINK")
    SYMLINK_DIR=$(dirname "$SYMLINK")
    ABS_TARGET=$(realpath "$SYMLINK_DIR/$TARGET")
    
    if [ ! -e "$ABS_TARGET" ]; then
        echo "⚠️ Target does not exist: $ABS_TARGET"
        continue
    fi

    TEMP_PATH="${SYMLINK}.real"
    
    # Copy target to temp path
    cp -R "$ABS_TARGET" "$TEMP_PATH"
    
    # Remove original symlink
    rm "$SYMLINK"
    
    # Rename temp copy to original symlink name
    mv "$TEMP_PATH" "$SYMLINK"
    
    echo "Replaced symlink with real copy at: $SYMLINK"
done

# Remove the Versions folder after flattening
find "$DEST" -type d -name "Versions" | while read -r VERSIONS_DIR; do
    echo "Removing flattened Versions folder: $VERSIONS_DIR"
    rm -rf "$VERSIONS_DIR"
done

echo -e "\n✅ Mac Catalyst .xcframework flattening complete."
