#!/bin/bash

# Convert a HTML file to PDF
# Optional take, as a second argument, the scale to use with scaleHTML.sh

SCALE=${3:-0.75}

# Verify if a HTML was provided
if [ -z "$1" ]; then
  echo "No HTML file provided"
  exit 1
fi

# Verify if a PDF was provided
if [ -z "$2" ]; then
  echo "No PDF file provided"
  exit 1
fi

# Call the scaleHTML.sh script with the appropriate arguments
echo 📏 Scaling "$1" to $SCALE...
echo ---
/usr/local/bin/scaleHTML.sh "$SCALE" "$1"

echo 🖨️  Converting "$1" to "$2"...
echo ---
chromium-browser --no-sandbox --headless --no-pdf-header-footer --print-to-pdf="$2" "$1"

echo ---
echo 🏁 Done