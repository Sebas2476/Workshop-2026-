#!/usr/bin/env bash
cd "$(dirname "$0")"

GREEN=$'\e[32m'
RED=$'\e[31m'
BOLD=$'\e[1m'
RESET=$'\e[0m'

ANSWERS=answers.txt

if [ ! -f "$ANSWERS" ]; then
  echo "${RED}${BOLD}FAIL:${RESET} $ANSWERS does not exist in $(pwd)"
  exit 1
fi

if ! grep -qi frontera "$ANSWERS"; then
  echo "${RED}${BOLD}FAIL:${RESET} $ANSWERS is missing the first passphrase"
  exit 1
fi

if ! grep -qiw devs "$ANSWERS"; then
  echo "${RED}${BOLD}FAIL:${RESET} $ANSWERS is missing the second passphrase"
  exit 1
fi

echo "${GREEN}${BOLD}"
echo "  ╔════════════════════════╗"
echo "  ║   LEVEL 03 COMPLETE    ║"
echo "  ╚════════════════════════╝"
echo "${RESET}"
