#!/bin/bash
set -e

# Paths
SWIFT_SRC="$HOME/Visual Studio Projects/Maui.InAppBilling/plugin.howitzergames.storekit2/swift/StoreKit2-swift/StoreKit2.xcframework"
EXTERNALS_DIR="$HOME/Visual Studio Projects/Maui.InAppBilling/plugin.howitzergames.storekit2/externals"
DEST="$EXTERNALS_DIR/StoreKit2.xcframework"

echo "📦 Copying StoreKit2.xcframework to externals..."
rm -rf "$DEST"
cp -R "$SWIFT_SRC" "$DEST"
echo "✅ Copy complete"

echo
echo "🔍 Processing xcframework slices..."

# Iterate through top-level xcframework slices
for SLICE in "$DEST"/*; do
    SLICE_NAME=$(basename "$SLICE")

    # Skip non-directories
    [ -d "$SLICE" ] || continue

    # Skip Mac Catalyst entirely
    if [[ "$SLICE_NAME" == *maccatalyst* ]]; then
        echo "⏭️  Skipping Mac Catalyst slice: $SLICE_NAME"
        continue
    fi

    # Only flatten iOS + Simulator
    if [[ "$SLICE_NAME" == ios-* || "$SLICE_NAME" == *simulator* ]]; then
        echo "🔧 Flattening symlinks in slice: $SLICE_NAME"
    else
        echo "⏭️  Skipping unknown slice: $SLICE_NAME"
        continue
    fi

    # --- Flatten Versions/Current first ---
    find "$SLICE" -type d -name "Versions" | while read -r VERSIONS_DIR; do
        CURRENT_LINK="$VERSIONS_DIR/Current"

        if [ -L "$CURRENT_LINK" ]; then
            TARGET_DIR=$(readlink "$CURRENT_LINK")
            ABS_TARGET_DIR=$(realpath "$VERSIONS_DIR/$TARGET_DIR")

            echo "  ↳ Replacing Versions/Current symlink"
            rm "$CURRENT_LINK"
            cp -R "$ABS_TARGET_DIR" "$VERSIONS_DIR/Current"
        fi
    done

    # --- Flatten remaining symlinks ---
    find "$SLICE" -type l | while read -r SYMLINK; do
        TARGET=$(readlink "$SYMLINK")
        SYMLINK_DIR=$(dirname "$SYMLINK")
        ABS_TARGET=$(realpath "$SYMLINK_DIR/$TARGET")

        if [ ! -e "$ABS_TARGET" ]; then
            echo "  ⚠️ Missing target for $SYMLINK"
            continue
        fi

        TEMP_PATH="${SYMLINK}.real"
        cp -R "$ABS_TARGET" "$TEMP_PATH"
        rm "$SYMLINK"
        mv "$TEMP_PATH" "$SYMLINK"

        echo "  ✔ Flattened: $SYMLINK"
    done

    # --- Remove Versions folders (safe for iOS only) ---
    find "$SLICE" -type d -name "Versions" | while read -r VERSIONS_DIR; do
        echo "  🧹 Removing Versions folder"
        rm -rf "$VERSIONS_DIR"
    done
done

echo
echo "✅ Flattening complete (iOS + Simulator only)"
