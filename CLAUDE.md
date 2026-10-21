# CLAUDE.md

Papers written by Tasso Evangelista, as Typst sources with their generated PDFs.

## Layout

- `educampo/`: academic works for the Licenciatura em Educação do Campo at UFRGS, in Brazilian Portuguese. They follow the ABNT conventions in [educampo/ABNT.md](educampo/ABNT.md); each document's own decisions and open points live in a `README.md` next to it.
- `pessoal/`: personal papers.
- `fonts/`: fonts bundled for Typst, each with its license. `mise` points `TYPST_FONT_PATHS` here.

## Building

- Typst is pinned through `mise` (`mise.toml`). Run it as `mise exec -- typst …`, since the bare shim may not resolve.
- `mise run pdf` rebuilds every PDF. To rebuild one file the same way:

  ```sh
  mise exec -- typst compile --creation-timestamp "$(date -r "$f" +%s)" "$f"
  ```

  Using the source's modification time as the creation timestamp keeps rebuilds of unchanged sources byte-identical.
- Generated PDFs are committed. Rebuild the PDF and commit it together with its source.

## Verifying changes

- Compile without warnings, and check that the page count changed only when expected (`pdfinfo`).
- Look at the pages that changed: render them with `pdftoppm` and inspect the images. Use `pdftotext` to check text, numbering and cross-references.

## Conventions

- Commit messages: `new(scope): …` for a new paper, otherwise `fix`, `chore` or `refactor`, with the top-level folder as scope.
- Write Typst comments in the document's language (pt-BR in `educampo/`).
- Don't change the authors' wording on your own. Point out typos and inconsistencies, and let the user decide; some apparent mistakes are deliberate (e.g. "matarias" is a valid word).

## Typst pitfalls met here

- A line starting with a number and a period, like `2018. Disponível…`, becomes a numbered list item. Escape it: `2018\.`.
- A custom `show heading` or `show figure` rule replaces the default block, so `set block(above: …)` no longer applies. Return `block(above: …, below: …, …)` from the rule itself.
- `v()` or a set rule placed right after a text line, without a blank line between them, falls inside the paragraph and is ignored or applies mid-paragraph.
- With `lang: "pt"`, Typst repeats a hyphen at the start of the next line when a line breaks at it, which would alter URLs. Links are set to `lang: "en"` to avoid it.
