#!/bin/bash
# Level 04 — Creating and Modifying
# Run this after each step to track your progress:  ./test.sh
 
GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'
DIM='\033[2m'; BOLD='\033[1m'; NC='\033[0m'
 
SHOW_CMD=false
[ "$1" = "--hint" ] || [ "$1" = "-h" ] && SHOW_CMD=true
 
STATE=".progress"
[ -f "$STATE" ] || : > "$STATE"
seen()     { grep -qx "$1" "$STATE" 2>/dev/null; }
remember() { seen "$1" || echo "$1" >> "$STATE"; }
 
declare -a ST TX HT CM   # status, text, nudge, explicit command (index 1-5)
 
set_step() { ST[$1]=$2; TX[$1]=$3; HT[$1]=$4; CM[$1]=$5; }
 
# --- Step 1: archive/ and archive/2026/ ---------------------------------
if [ -d archive/2026 ]; then
  remember step1
  set_step 1 pass "archive/2026/ created"
elif [ -d archive ]; then
  set_step 1 error "2026/ is missing inside archive/" \
    "you made archive/ alone — one flag lets mkdir build a whole path at once" \
    "mkdir -p archive/2026"
else
  set_step 1 todo "create archive/ with 2026/ inside it" \
    "two directories, one nested in the other — the table has a flag for that" \
    "mkdir -p archive/2026"
fi
 
# --- Step 2: scratch.txt created ----------------------------------------
if [ -e archive/scratch.txt ] || seen step2; then
  remember step2
  set_step 2 pass "archive/scratch.txt created"
elif [ -d archive ]; then
  set_step 2 todo "create archive/scratch.txt" \
    "which command makes an empty file? run ./test.sh again before you delete it" \
    "touch archive/scratch.txt"
else
  set_step 2 blocked "create archive/scratch.txt"
fi
 
# --- Step 3: copy into archive/2026/ ------------------------------------
copy_present=false
[ -f archive/2026/field-notes.txt ] && copy_present=true
[ -f archive/2026/notes-2026.txt ] && copy_present=true
 
if $copy_present && [ -f field-notes.txt ]; then
  remember step3
  set_step 3 pass "field-notes.txt copied into archive/2026/"
elif $copy_present && [ ! -f field-notes.txt ]; then
  set_step 3 error "the original field-notes.txt is gone" \
    "mv relocates a file. You wanted two copies, not one in a new place. ./reset.sh starts over" \
    "./reset.sh, then: cp field-notes.txt archive/2026/"
elif [ -d archive/2026 ]; then
  set_step 3 todo "copy field-notes.txt into archive/2026/" \
    "the original has to survive this step — that rules out one of the two commands" \
    "cp field-notes.txt archive/2026/"
else
  set_step 3 blocked "copy field-notes.txt into archive/2026/"
fi
 
# --- Step 4: rename the copy --------------------------------------------
if [ -f archive/2026/notes-2026.txt ] && [ ! -f archive/2026/field-notes.txt ]; then
  if [ ! -f field-notes.txt ] || cmp -s field-notes.txt archive/2026/notes-2026.txt; then
    remember step4
    set_step 4 pass "renamed to notes-2026.txt"
  else
    set_step 4 error "notes-2026.txt doesn't match the original" \
      "cat both files and compare them — did the right file get copied?" \
      "cat field-notes.txt archive/2026/notes-2026.txt"
  fi
elif [ -f archive/2026/notes-2026.txt ] && [ -f archive/2026/field-notes.txt ]; then
  set_step 4 error "both names exist in archive/2026/" \
    "you have two files where there should be one — only notes-2026.txt should remain" \
    "rm archive/2026/field-notes.txt"
elif [ -f notes-2026.txt ]; then
  set_step 4 error "you renamed the original instead of the copy" \
    "check where notes-2026.txt ended up — it should be inside archive/2026/" \
    "mv notes-2026.txt field-notes.txt, then rename the copy instead"
elif [ -f archive/2026/field-notes.txt ]; then
  set_step 4 todo "rename the copy to notes-2026.txt" \
    "there is no rename command in Linux. What else moves a file to a new name?" \
    "mv archive/2026/field-notes.txt archive/2026/notes-2026.txt"
else
  set_step 4 blocked "rename the copy to notes-2026.txt"
fi
 
# --- Step 5: delete scratch.txt -----------------------------------------
if seen step2 && [ ! -e archive/scratch.txt ]; then
  remember step5
  set_step 5 pass "archive/scratch.txt deleted"
elif [ -e archive/scratch.txt ]; then
  set_step 5 todo "delete archive/scratch.txt" \
    "look at it with ls before you remove it — that habit will save you one day" \
    "rm archive/scratch.txt"
else
  set_step 5 blocked "delete archive/scratch.txt"
fi
 
# --- render --------------------------------------------------------------
echo
echo -e "${BOLD}Level 04 — Creating and Modifying${NC}"
echo
 
# Starting file missing, and no sign the learner ever had it.
if [ ! -f field-notes.txt ] && [ "${ST[3]}" != "error" ] \
   && [ ! -f archive/2026/notes-2026.txt ] && [ ! -f archive/2026/field-notes.txt ]; then
  echo -e "  ${RED}field-notes.txt is not in this directory.${NC}"
  echo -e "  This level needs it as a starting file. Restore it, then run ./test.sh again."
  echo
  exit 1
fi
 
passed=0
next_shown=false
for i in 1 2 3 4 5; do
  case ${ST[$i]} in
    pass)
      echo -e "  ${GREEN}[✔]${NC} Step $i — ${TX[$i]}"
      passed=$((passed+1)) ;;
    error)
      echo -e "  ${RED}[✘]${NC} Step $i — ${TX[$i]}"
      echo -e "      ${YELLOW}↳${NC} ${HT[$i]}"
      $SHOW_CMD && [ -n "${CM[$i]}" ] && echo -e "      ${DIM}\$ ${CM[$i]}${NC}" ;;
    todo)
      if ! $next_shown; then
        echo -e "  ${YELLOW}[▸]${NC} Step $i — ${TX[$i]}"
        echo -e "      ${YELLOW}↳${NC} ${HT[$i]}"
        $SHOW_CMD && [ -n "${CM[$i]}" ] && echo -e "      ${DIM}\$ ${CM[$i]}${NC}"
        next_shown=true
      else
        echo -e "  ${DIM}[ ] Step $i — ${TX[$i]}${NC}"
      fi ;;
    blocked)
      echo -e "  ${DIM}[ ] Step $i — ${TX[$i]}${NC}" ;;
  esac
done
 
echo
bar=""
for i in 1 2 3 4 5; do
  [ $i -le $passed ] && bar="${bar}█" || bar="${bar}░"
done
echo -e "  ${BOLD}${bar}${NC}  $passed / 5 steps complete"
echo
 
if [ $passed -eq 5 ]; then
  echo -e "  ${GREEN}${BOLD}Level 04 complete.${NC} On to Level 05."
  echo
  exit 0
fi
if $SHOW_CMD; then
  echo -e "  ${DIM}Run ./test.sh again after your next step.${NC}"
else
  echo -e "  ${DIM}Run ./test.sh again after your next step."
  echo -e "  Really stuck? ./test.sh --hint shows the exact command.${NC}"
fi
echo
exit 1
