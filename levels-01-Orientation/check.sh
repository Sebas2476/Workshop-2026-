#!/usr/bin/env bash
cd "$(dirname "$0")"

GREEN=$'\e[32m'
RED=$'\e[31m'
BOLD=$'\e[1m'
RESET=$'\e[0m'

if [ ! -f notes.txt ]; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt does not exist in $(pwd)"
	echo "      Create it here with nano, and paste your pwd and whoami output inside."
	exit 1
fi

# Accept the path whether they ran pwd in this folder or at the repo root.
HERE=$(pwd)
ROOT=$(cd .. && pwd)
if ! grep -qF "$HERE" notes.txt && ! grep -qF "$ROOT" notes.txt; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt is missing your pwd output"
	echo "      Run: pwd"
	echo "      Expected to find a line containing: $HERE"
	exit 1
fi

# Ignore the pwd line when looking for the username — on many systems the
# path contains the username, which would satisfy this check on its own.
if ! grep -vF "$HERE" notes.txt | grep -vF "$ROOT" | grep -qF "$(whoami)"; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt is missing your whoami output"
	echo "      Run: whoami"
	echo "      Expected to find a line containing: $(whoami)"
	exit 1
fi

echo "${GREEN}${BOLD}"
echo "  ╔════════════════════════╗"
echo "  ║   LEVEL 01 COMPLETE    ║"
echo "  ╚════════════════════════╝"
echo "${RESET}"
