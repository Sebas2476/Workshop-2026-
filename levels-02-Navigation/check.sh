#!/usr/bin/env bash
cd "$(dirname "$0")"

NOTES=../levels-01-Orientation/notes.txt

if [ ! -f "$NOTES" ]; then
  echo "FAIL: notes.txt does not exist"
  exit 1
fi

if ! grep -qi TRAVERSE "$NOTES"; then
  echo "FAIL: notes.txt does not have the passphrase"
  exit 1
fi

echo "PASS: level 02 complete"
