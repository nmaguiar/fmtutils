# 🖼️  ImageMagick

ImageMagick is a powerful suite for image manipulation, supporting a wide range of formats and operations.

## Supported Image Formats

* ↔︎ JPEG (via imagemagick-jpeg)
* ↔︎ HEIC/HEIF (via imagemagick-heic)
* ↔︎ JPEG XL (via imagemagick-jxl)
* ↔︎ PDF (via imagemagick-pdf)
* ↔︎ SVG (via imagemagick-svg)
* ↔︎ TIFF (via imagemagick-tiff)
* ↔︎ WebP (via imagemagick-webp)
* ↔︎ PNG, GIF, BMP, ICO, and many more (core ImageMagick)

## Common Operations

* ↔︎ Convert between image formats (e.g., PNG → JPEG, SVG → PDF)
* ↔︎ Resize, crop, rotate, and flip images
* ↔︎ Adjust brightness, contrast, and colors
* ↔︎ Add text, watermarks, or shapes
* ↔︎ Create thumbnails
* ↔︎ Combine or montage images
* ↔︎ Extract metadata
* ↔︎ Optimize images for web

## Example Commands

Convert an image from PNG to JPEG:

```sh

magick input.png output.jpg

```

Resize an image to 800x600:

```sh

magick input.jpg -resize 800x600 output.jpg

```

Convert a PDF page to PNG:

```sh

magick input.pdf[0] output.png

```

## Notes

- Some formats (e.g., HEIC, JXL, WebP, TIFF, PDF, SVG) require the corresponding module to be installed, as listed above.
- Use `magick` as the modern command-line entry point (e.g., `magick convert ...`).
- For more details, see the [ImageMagick documentation](https://imagemagick.org/script/command-line-tools.php).

