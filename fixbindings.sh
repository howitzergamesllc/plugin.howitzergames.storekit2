#!/bin/bash
set -e

echo "🔹 Starting bindings fix..."

BINDING_ROOT="./bindings"
PROJECT_DIR="./source/Apple/StoreKit2"
PROCESS_FILES=("ApiDefinitions.cs" "Enums.cs")

mkdir -p "$PROJECT_DIR"

############################################
# 1️⃣ Copy and rename files
############################################
cp "$BINDING_ROOT/ApiDefinitions.cs" "$PROJECT_DIR/"
cp "$BINDING_ROOT/StructsandEnums.cs" "$PROJECT_DIR/Enums.cs"
echo "✅ Copied and renamed binding files"

############################################
# 2️⃣ Remove unwanted attributes
############################################
for f in "${PROCESS_FILES[@]}"; do
    FILE="$PROJECT_DIR/$f"
    sed -i '' \
        -e 's/\[Verify *(MethodToProperty *)\]//g' \
        -e 's/\[Introduced *(PlatformName\.VisionOS[^]]*)\]//g' \
        -e 's/\[Watch ([^]]*)\]//g' \
        -e 's/NoWatch *, *//g' \
        -e 's/, *NoWatch//g' \
        "$FILE"
    echo "✅ Removed [Verify], VisionOS, and Watch/NoWatch attributes in $f"
done

############################################
# 3️⃣ Rename NSUUID → NSUuid and NSURL → NSUrl
############################################
for f in "${PROCESS_FILES[@]}"; do
    FILE="$PROJECT_DIR/$f"
    sed -i '' 's/NSUUID/NSUuid/g' "$FILE"
    sed -i '' 's/NSURL/NSUrl/g' "$FILE"
done
echo "✅ Renamed NSUUID → NSUuid and NSURL → NSUrl"

############################################
# 4️⃣ Add [Async] above async Export methods
############################################
for f in "${PROCESS_FILES[@]}"; do
    FILE="$PROJECT_DIR/$f"
    awk '
    /^[[:space:]]*\[Export *\(".*Async.*"\)\]/ {
        # capture leading whitespace
        match($0, /^[[:space:]]*/)
        indent = substr($0, RSTART, RLENGTH)
        print indent "[Async]"
    }
    { print }
    ' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
done
echo "✅ Added [Async] above async methods"

############################################
# 5️⃣ Add [BaseType(typeof(NSObject))] if missing
############################################
for f in "${PROCESS_FILES[@]}"; do
    FILE="$PROJECT_DIR/$f"
    awk '
    {
        # store current line
        lines[NR] = $0

        # detect class or interface declaration
        if ($0 ~ /^[[:space:]]*(public[[:space:]]+)?(partial[[:space:]]+)?(class|interface)[[:space:]]+[A-Za-z0-9_]+/) {

            # check previous 4 lines for BaseType
            baseFound = 0
            for (i = NR-4; i < NR; i++) {
                if (lines[i] ~ /BaseType/) {
                    baseFound = 1
                    break
                }
            }

            if (!baseFound) {
                # insert BaseType above declaration with proper indentation
                match($0, /^[[:space:]]*/)
                indent = substr($0, RSTART, RLENGTH)
                print indent "[BaseType(typeof(NSObject))]"
            }
        }

        # print current line
        print $0
    }
    ' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
done
echo "✅ Added [BaseType(typeof(NSObject))] where needed"

############################################
# 6️⃣ Wrap files in namespace StoreKit2 and fix using statements
############################################
wrap_file() {
    FILE="$1"
    TMP=$(mktemp)

    awk '/^using /{print}' "$FILE" > "$TMP.usings"

    sed -i '' 's/using StoreKit2;/using StoreKit;/' "$TMP.usings"

    if ! grep -q "using UIKit;" "$TMP.usings"; then
        echo "using UIKit;" >> "$TMP.usings"
    fi

    awk '!/^using /{print}' "$FILE" > "$TMP.code"

    {
        cat "$TMP.usings"
        echo ""
        echo "namespace StoreKit2 {"
        cat "$TMP.code"
        echo "}"
    } > "$FILE"

    rm -f "$TMP.usings" "$TMP.code"
}

for f in "${PROCESS_FILES[@]}"; do
    wrap_file "$PROJECT_DIR/$f"
done
echo "✅ Wrapped files in namespace StoreKit2 and fixed using statements"

############################################
# 7️⃣ Convert unsafe int* → NSArray
############################################
for f in "${PROCESS_FILES[@]}"; do
    FILE="$PROJECT_DIR/$f"
    sed -i '' 's/unsafe int\*/NSArray/g' "$FILE"
done
echo "✅ Converted unsafe int* → NSArray"

echo "🎉 Bindings fix completed successfully!"
