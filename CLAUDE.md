# CLAUDE.md

Papers written by Tasso Evangelista, as Typst sources with their generated PDFs.

## Layout

- `educampo/`: academic works for the Licenciatura em Educação do Campo at UFRGS, in Brazilian Portuguese. They follow the ABNT conventions in [educampo/ABNT.md](educampo/ABNT.md); each document's own decisions and open points live in a `README.md` next to it.
- `pessoal/`: personal papers.
- `fonts/`: fonts bundled for Typst, each with its license. `mise` points `TYPST_FONT_PATHS` here.

## Building

- Typst and Poppler (`pdfinfo`, `pdftoppm`, `pdftotext`) are pinned through `mise` (`mise.toml`); `mise install` fetches them. Run them as `mise exec -- <tool> …`, since the bare shims may not resolve.
- `mise run pdf` rebuilds every PDF under the current folder; `mise run pdf <file.typ>…` rebuilds only the given sources (paths relative to the current folder). Always build through this task rather than calling `typst compile` directly.
- The task stamps each PDF with the author date of the last commit that changed its source, so rebuilding an unchanged source gives a byte-identical PDF, even after checkouts or rebases. A source with uncommitted changes gets its modification time instead.
- Generated PDFs are committed together with their source. Since the timestamp comes from the commit, the PDF built before committing carries a provisional date: after committing, run `mise run pdf` again and, if the PDF changed, `git commit --amend --no-edit` it in. Amending keeps the author date, so the PDF then stays stable.

## Verifying changes

- Compile without warnings, and check that the page count changed only when expected (`mise exec -- pdfinfo …`).
- Look at the pages that changed: render them with `mise exec -- pdftoppm …` and inspect the images. Use `mise exec -- pdftotext …` to check text, numbering and cross-references.

## Conventions

- Commit messages: `new(scope): …` for a new paper, otherwise `fix`, `chore` or `refactor`, with the top-level folder as scope.
- Write Typst comments in the document's language (pt-BR in `educampo/`).
- Don't change the authors' wording on your own. Point out typos and inconsistencies, and let the user decide; some apparent mistakes are deliberate (e.g. "matarias" is a valid word).

## Typst pitfalls met here

- A line starting with a number and a period, like `2018. Disponível…`, becomes a numbered list item. Escape it: `2018\.`.
- A custom `show heading` or `show figure` rule replaces the default block, so `set block(above: …)` no longer applies. Return `block(above: …, below: …, …)` from the rule itself.
- `v()` or a set rule placed right after a text line, without a blank line between them, falls inside the paragraph and is ignored or applies mid-paragraph.
- With `lang: "pt"`, Typst repeats a hyphen at the start of the next line when a line breaks at it, which would alter URLs. Links are set to `lang: "en"` to avoid it.
