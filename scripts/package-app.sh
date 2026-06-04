#!/bin/bash
set -euo pipefail

APP_NAME="EarthDrift"
BUILD_DIR=".build"
CONFIG="${1:-debug}"
BINARY="$BUILD_DIR/$CONFIG/$APP_NAME"
BUNDLE_DIR="$BUILD_DIR/$APP_NAME.app"
MACOS_DIR="$BUNDLE_DIR/Contents/MacOS"
RESOURCES_DIR="$BUNDLE_DIR/Contents/Resources"

echo "=== Packaging $APP_NAME ($CONFIG) ==="

echo "  Creating bundle structure..."
rm -rf "$BUNDLE_DIR"
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

echo "  Copying binary..."
cp "$BINARY" "$MACOS_DIR/$APP_NAME"
chmod +x "$MACOS_DIR/$APP_NAME"

echo "  Generating Info.plist..."
cat > "$BUNDLE_DIR/Contents/Info.plist" << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>EarthDrift</string>
    <key>CFBundleIdentifier</key>
    <string>com.earthdrift.app</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>Earth Drift</string>
    <key>CFBundleDisplayName</key>
    <string>Earth Drift</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>26.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>LSUIElement</key>
    <false/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
PLIST

echo "  Creating PkgInfo..."
echo -n "APPL????" > "$BUNDLE_DIR/Contents/PkgInfo"

echo ""
echo "  Bundle created at: $BUNDLE_DIR"
echo ""
echo "  To launch: open $BUNDLE_DIR"
echo ""

if [ "${2:-}" = "--launch" ]; then
    echo "  Launching..."
    open "$BUNDLE_DIR"
fi
