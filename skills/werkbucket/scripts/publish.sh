#!/bin/sh
# Publish with the werkbucket CLI: the same as `werkbucket publish --json "$@"`,
# plus an install hint when the CLI is missing.
set -eu

hint="Install it with: curl -fsSL https://werkbucket.com/install.sh | sh"
if ! p=$(command -v werkbucket 2>/dev/null); then
	echo "werkbucket is not installed. $hint" >&2
	exit 127
fi
# A slop command is a common name (Debian and Ubuntu ship an unrelated X11 tool), so
# runs only when it is the CLI's wrapper, which carries a marker on line 2.
# shellcheck disable=SC2194 # the case word is the CLI command, filled in by the render
case werkbucket in
slop)
	[ "$(sed -n 2p "$p" 2>/dev/null)" = "# managed-by: werkbucket" ] || {
		echo "$p is not the werkbucket CLI's werkbucket. $hint, then put its directory first on PATH." >&2
		exit 127
	}
	;;
esac

exec werkbucket publish --json "$@"
