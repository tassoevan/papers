# Papers

Papers I wrote for personal or academic reasons.

## Building

The documents are written in [Typst](https://typst.app/), and the generated PDFs are committed next to their sources. The tools are pinned with [mise](https://mise.jdx.dev/), which also points Typst to the fonts bundled in `fonts/`.

To rebuild all the PDFs:

```sh
mise install   # fetch the pinned Typst and Poppler, once
mise run pdf   # compile every .typ file under the current folder into a PDF next to it
mise run pdf path/to/file.typ   # or only the given sources
```

Each PDF gets the author date of the last commit that changed its source as its creation timestamp, so rebuilding an unchanged source produces a byte-identical PDF, even after checkouts or rebases. Sources with uncommitted changes use their modification time instead.
