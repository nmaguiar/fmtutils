#!/bin/bash
# Inject a body scale style tag or change an existing one right after <head *> if it appears after <html>,
# otherwise after <html>. The zoom factor will be provided as the first argument.

ZOOM_FACTOR="${1:-0.75}"
FILE="$2"

# Check if the style body zoom tag was already previously applied
if grep -q "<style>body { zoom: " "$FILE"; then
    sed -i "s|<style>body { zoom: .\+; }<\/style>|<style>body { zoom: $ZOOM_FACTOR; }<\/style>|" "$FILE"
else
    # Insert after first <head> after <html>, or after <html> if no <head> found
    HTML_LINE=$(grep -n '<html[^>]*>' "$FILE" | head -n1 | cut -d: -f1)
    HEAD_LINE=$(awk "NR>$HTML_LINE && /<head[^>]*>/" "$FILE" | head -n1)
    if [ -n "$HEAD_LINE" ]; then
        # Insert after first <head> after <html>
        sed -i "/<head[^>]*>/a <style>body { zoom: $ZOOM_FACTOR; }</style>" "$FILE"
    else
        # Insert after <html>
        sed -i "/<html[^>]*>/a <style>body { zoom: $ZOOM_FACTOR; }</style>" "$FILE"
    fi
fi
