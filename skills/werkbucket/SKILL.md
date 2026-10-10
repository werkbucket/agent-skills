---
name: werkbucket
description: Publish files and folders to shareable werkbucket URLs. Use when the user asks to publish, share, host or deploy something you built or have on disk: a page, a static site, a report, a PDF, an image, a data file.
---

# Publish with werkbucket

`werkbucket publish` publishes any file or folder, each under its own name. Several arguments, and glob patterns such as `'*.md'`, go live together in one publish.

1. Put what you want to share on disk. A file is published as itself; a folder is published with everything in it (names that start with `.`, symlinks and special files are skipped).
2. Know where it will be served. The name is the file's or folder's own name, at the root of the user's site:
   - `report.pdf` is at `/report.pdf`.
   - A folder `site` is at `/site/`, and its files at `/site/<file>`. `index.html` is served for a folder URL, so `site/index.html` is the page at `/site/`. A folder with no `index.html` still serves its files by path.
   - With `--project`, everything goes under `/projects/<slug>/…`.
3. Use relative paths for links, scripts, styles and images inside a folder (`css/site.css`, not `/css/site.css` or `file:///…`), so the folder works wherever it is served.
4. Nothing is scanned for secrets. HTML and SVG pages are checked for abuse, and a flagged entry shows an under-review page until a person reviews it. Keep API keys, tokens, passwords and `.env` files out of what you publish.
5. Publish as unlisted (the default: anyone with the link). Ask the user before you make anything public with `--access public`: a public entry is indexed by search engines. To share with a company or with named people, use `--access google --allow-domain <d>` or `--allow-email <e>`; `--access private` limits it to account members; `--access password` needs `--password-stdin`.
6. To put new entries in a project, add `--project` with the project's slug: a new entry uses the project's access, so run `werkbucket projects` first and ask the user before you publish into a public project.
7. Run `werkbucket publish --json` with the paths, for example `werkbucket publish --json site report.pdf` (or `scripts/publish.sh site report.pdf`, which runs the same command).
8. Read `entries[].url` from the JSON result and give it to the user.

To change who can view an entry afterwards, run `werkbucket access <path> <mode>`; access is set on the top-level file or folder, not on a file inside a folder. To see what is published, run `werkbucket ls` (or `werkbucket ls <folder>` for its files). To take something down, run `werkbucket rm <path>`; a folder needs `werkbucket rm -r <folder>`. Ask the user before you delete.

If `werkbucket` is not installed, run:

    curl -fsSL https://werkbucket.com/install.sh | sh

## Results and errors

- Exit 0: the JSON has `project`, `files`, `uploaded`, `unchanged`, `bytes` and `entries`, each entry with `name`, `path`, `kind` (`file` or `folder`), `url`, `access_mode` and `files`.
- Exit 2: a bad flag or argument, or a name that cannot be published (for example `projects` at the root). Show the `error.message` to the user.
- Exit 4: not signed in. Ask the user to run `werkbucket login` in a terminal.
- Exit 7: a name is already a file where you publish a folder, or the reverse. Choose another name or remove the old one with `werkbucket rm`.
- Exit 8: the account has no active subscription. Ask the user to run `werkbucket billing`.
- Other exit codes: show the `error.message` from the JSON to the user.
