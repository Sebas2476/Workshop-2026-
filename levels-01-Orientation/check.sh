#!/usr/bin/env bash
cd "$(dirname "$0")"

if [ ! -f notes.txt ]; then
	echo "FAIL: notes.txt does not exist"
	exit 1
fi


if ! grep -qF "$(pwd)" notes.txt; then
	echo "Fail: notes.txt is missing your pwd output"
	exit 1
fi


if ! grep -qF "$(whoami)" notes.txt; then
	echo "FAIL: notes.txt is missing your pwd output"
	exit 1
fi


echo "PASS: level 01 complete"

