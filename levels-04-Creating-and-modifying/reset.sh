#!/bin/bash
# Level 04 — reset to the starting state:  ./reset.sh

GREEN='\033[0;32m'; NC='\033[0m'

rm -rf archive
rm -f .progress notes-2026.txt

cat > field-notes.txt <<'NOTES'
FIELD NOTES — Frontera Devs Linux Workshop
==========================================

Day 1. The shell has no undo. rm is permanent.
Day 2. cp leaves the original alone. mv does not.
Day 3. Ran ls on a path before deleting it. Glad I did.
Day 4. mkdir -p builds a whole path in one command.
Day 5. Still here. Still have all my files.
NOTES

echo -e "${GREEN}Level 04 reset.${NC} Run ./test.sh to start over."
