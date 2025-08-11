# Examples

List of examples:

| Category | Example title |
|----------|---------------|
| Convert | Convert MD into PDF |
| Convert | Convert DOCx into MD |
| Convert | Convert MD into DOCx |
| Convert | Convert MD to HTML |

> To search for a specific example type '/Convert markdown into<ENTER>' and use the arrow keys to navigate

---

## 🖨️ Convert MD into PDF

Execute:

```bash

oafp in.md out=html outfile=/fmtutils/out.html htmlopen=false
scaleHTML.sh 0.75 /fmtutils/out.html
chromium-browser --no-sandbox --headless --no-pdf-header-footer --print-to-pdf=out.pdf file:///fmtutils/out.html
rm out.html

```

> You can change the PDF per page scale of the original HTML using scaleHTML.sh that will try to inject a body zoom factor css rule

---

## ➡️ Convert DOCx into MD

> If you have a .doc document use Word or equivalent to convert it to .docx first.

Execute:

```bash

pandoc my-example.docx -o my-example.md

```

---

## ➡️ Convert MD into DOCx

Execute:

```bash

pandoc my-example.md -o my-example.docx

```

---

## 📜 Convert MD to HTML

To convert MD (markdown) into HTML there are several options:

### Convert to a full-render HTML

If you want to a final standalone HTML that fully renders the original markdown including syntax-highlight and Mermaid flowcharts, for example, execute:

```bash

oafp my-original.md out=html outfile=/fmtutils/my-output.html htmlopen=false

```

### Convert to a simple HTML

If you want a straight-forward HTML conversion execute:

```bash

pandoc my-original.md -t html5 -o my-output.html

```

> This is useful when you need to copy to other tools that accept basic HTML as input
