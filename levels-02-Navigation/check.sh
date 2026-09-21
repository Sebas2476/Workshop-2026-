#!/usr/bin/env bash
cd "$(dirname "$0")"

GREEN=$'\e[32m'
RED=$'\e[31m'
BOLD=$'\e[1m'
RESET=$'\e[0m'

NOTES=notes.txt

if [ ! -f "$NOTES" ]; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt does not exist in $(pwd)"
	echo "      Come back to this folder and create it, then write the passphrase inside."
	exit 1
fi

if ! grep -qi TRAVERSE "$NOTES"; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt does not have the passphrase in it yet."
	echo "      flag.txt is somewhere below this folder. Use ls and cd to find it, then cat it."
	exit 1
fi

echo "${GREEN}${BOLD}"
echo "  ╔════════════════════════╗"
echo "  ║   LEVEL 02 COMPLETE    ║"
echo "  ╚════════════════════════╝"
echo "${RESET}"
