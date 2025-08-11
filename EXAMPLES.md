# Examples

List of examples:

| Category | Example title |
|----------|---------------|
| Convert | Convert markdown into PDF |

> To search for a specific example type '/Convert markdown into<ENTER>' and use the arrow keys to navigate

## 🖨️ Convert markdown into PDF

Execute:

```bash

oafp in.md out=html outfile=/fmtutils/out.html htmlopen=false
scaleHTML.sh 0.75 /fmtutils/out.html
chromium-browser --no-sandbox --headless --no-pdf-header-footer --print-to-pdf=out.pdf file:///fmtutils/out.html
rm out.html

```

> You can change the PDF per page scale of the original HTML using scaleHTML.sh that will try to inject a body zoom factor css rule