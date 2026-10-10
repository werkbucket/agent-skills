# werkbucket skill

An agent skill that publishes files and folders to shareable werkbucket URLs, each under its
own name, by running `werkbucket publish --json`. It also covers `werkbucket access`, `ls` and `rm`. It needs the `werkbucket`
CLI; if the CLI is missing, the skill tells the agent how to install it.

## Install

With the CLI (writes `~/.claude/skills/werkbucket/`, or `./.claude/skills/werkbucket/` with
`--project`):

    werkbucket skill install

The CLI's installer (`curl -fsSL https://<app-domain>/install.sh | sh`) already runs this, for
both brands, unless it is given `--no-skill`.

In slop mode the same skill is the slopbucket brand's: `slop skill install` writes
`~/.claude/skills/slopbucket/` (or `./.claude/skills/slopbucket/` with `--project`), and its
commands, install line and app URL are `slop`'s and slopbucket's. The CLI renders it at install
time; `slop update` keeps both brands' installs current.

As a Claude Code plugin:

    /plugin marketplace add mcgarylabs/werkbucket-skill
    /plugin install werkbucket@werkbucket

This directory is the source; a release mirrors it, with the app URL, version, command and brand placeholders filled in,
to `mcgarylabs/werkbucket-skill`. The mirror holds the werkbucket render only; the slopbucket
render exists only on a machine that ran the installer or `slop skill install`.
