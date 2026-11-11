# Papers

Papers I wrote for personal or academic reasons.

## Building

The documents are written in [Typst](https://typst.app/), and the generated PDFs are committed next to their sources. The tools are pinned with [mise](https://mise.jdx.dev/), which also points Typst to the fonts bundled in `fonts/`.

To rebuild all the PDFs:

```sh
mise install   # fetch the pinned Typst and Poppler, once
git config core.hooksPath .githooks   # enable the pre-commit hook, once
mise run pdf   # compile every .typ file under the current folder into a PDF next to it
mise run pdf path/to/file.typ   # or only the given sources
mise run watch path/to/file.typ # recompile the given sources on every change, until Ctrl-C
```

A source that differs from the last commit gets its modification time as the PDF's creation timestamp; an unchanged source reuses the date stored in its committed PDF, so rebuilding it produces a byte-identical PDF, even after checkouts or rebases.

The pre-commit hook rebuilds and stages the PDF of every source whose folder has staged changes, so each commit carries PDFs that match its sources. It refuses the commit if that folder also has unstaged changes, since the PDF is built from the working tree.
