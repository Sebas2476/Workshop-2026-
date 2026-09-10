#!/usr/bin/env bash
cd "$(dirname "$0")"

GREEN=$'\e[32m'
RED=$'\e[31m'
BOLD=$'\e[1m'
RESET=$'\e[0m'

if [ ! -f notes.txt ]; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt does not exist in $(pwd)"
	exit 1
fi


if ! grep -qF "$(pwd)" notes.txt; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt is missing your pwd output"
	exit 1
fi


if ! grep -qF "$(whoami)" notes.txt; then
	echo "${RED}${BOLD}FAIL:${RESET} notes.txt is missing your whoami output"
	exit 1
fi


echo "${GREEN}${BOLD}"
echo "  ╔════════════════════════╗"
echo "  ║   LEVEL 01 COMPLETE    ║"
echo "  ╚════════════════════════╝"
echo "${RESET}"
