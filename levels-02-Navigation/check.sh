#!/usr/bin/env bash
cd "$(dirname "$0")"

GREEN=$'\e[32m'
RED=$'\[31m'
BOLD=$'\1m'
RESET=$'0m'

NOTES=../levels-01-Orientation/notes.txt

if [ ! -f "$NOTES" ]; then
  echo "${RED}${BOLD}FAIL:${RESET} notes.txt does not exist"
  exit 1
fi

if ! grep -qi TRAVERSE "$NOTES"; then
  echo "${GREEN}${BOLD}PASS: level 02 complete${RESET}"
  exit 1
fi

echo "${GREEN}${BOLD}"
echo "  ╔════════════════════════╗"
echo "  ║   LEVEL 02 COMPLETE    ║"
echo "  ╚════════════════════════╝"
echo "${RESET}"
