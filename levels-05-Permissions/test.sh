#!/bin/bash
# Level 05 — Permissions
# Run this after each step to track your progress:  ./test.sh
# Stuck? ./test.sh --hint

GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'
DIM='\033[2m'; BOLD='\033[1m'; NC='\033[0m'

SHOW_CMD=false
[ "$1" = "--hint" ] || [ "$1" = "-h" ] && SHOW_CMD=true

# Fresh clone: git cannot store file modes (444, 640...), so the level's
# starting permissions have to be laid down by reset.sh on first run.
if [ ! -f .progress ]; then
  bash ./reset.sh >/dev/null 2>&1
fi

STATE=".progress"
[ -f "$STATE" ] || : > "$STATE"
seen()     { grep -qx "$1" "$STATE" 2>/dev/null; }
remember() { seen "$1" || echo "$1" >> "$STATE"; }

mode() { stat -c %a "$1" 2>/dev/null || stat -f %Lp "$1" 2>/dev/null; }
# Test the owner's bits directly. [ -w ] and [ -x ] lie when you are root.
owner_has() { # owner_has <file> <4|2|1>
  local m; m=$(mode "$1"); [ -z "$m" ] && return 1
  m=${m: -3}; local d=${m:0:1}
  [ $(( d & $2 )) -ne 0 ]
}

declare -a ST TX HT CM   # status, text, nudge, explicit command (index 1-5)
set_step() { ST[$1]=$2; TX[$1]=$3; HT[$1]=$4; CM[$1]=$5; }

# --- Step 1: make hello.sh executable and run it ------------------------
if [ ! -f hello.sh ]; then
  set_step 1 error "hello.sh is missing" \
    "this level ships with it — ./reset.sh restores the starting files" \
    "./reset.sh"
elif owner_has hello.sh 1 && [ -f greeting.txt ]; then
  remember step1
  set_step 1 pass "hello.sh made executable and run"
elif owner_has hello.sh 1; then
  set_step 1 todo "now run ./hello.sh" \
    "the bit is set. Try the exact command that failed a minute ago" \
    "./hello.sh"
else
  set_step 1 todo "make hello.sh executable, then run it" \
    "run ls -l and compare hello.sh with reset.sh. One of them runs. Spot the difference" \
    "chmod +x hello.sh && ./hello.sh"
fi

# --- Step 2: make notes.txt writable and append -------------------------
if [ ! -f notes.txt ]; then
  set_step 2 error "notes.txt is missing" \
    "./reset.sh restores the starting files" "./reset.sh"
else
  n=$(wc -l < notes.txt)
  if owner_has notes.txt 2 && [ "$n" -gt 3 ]; then
    remember step2
    set_step 2 pass "notes.txt made writable and edited"
  elif owner_has notes.txt 2; then
    set_step 2 todo "add a line to notes.txt" \
      "it accepts changes now. Open it and leave your mark" \
      "nano notes.txt"
  else
    set_step 2 todo "make notes.txt writable" \
      "ls -l notes.txt and count the w's. There aren't any" \
      "chmod +w notes.txt"
  fi
fi

# --- Step 3: lock secret.txt to the owner -------------------------------
if [ ! -f secret.txt ]; then
  set_step 3 error "secret.txt is missing" \
    "./reset.sh restores the starting files" "./reset.sh"
else
  m=$(mode secret.txt)
  if [ "$m" = "600" ]; then
    remember step3
    set_step 3 pass "secret.txt locked down to 600"
  elif [ "$m" = "700" ] || [ "$m" = "640" ] || [ "$m" = "660" ]; then
    set_step 3 error "secret.txt is $m — close, but not right" \
      "you granted something a text file has no use for. Of r, w and x, which does a document actually need?" \
      "chmod 600 secret.txt"
  else
    set_step 3 todo "lock secret.txt to owner-only access" \
      "it's $m . Three slots, three digits. Two of those slots shouldn't exist" \
      "chmod 600 secret.txt"
  fi
fi

# --- Step 4: hello.sh to exactly 755 ------------------------------------
if [ ! -f hello.sh ]; then
  set_step 4 blocked "set hello.sh to 755"
else
  m=$(mode hello.sh)
  if [ "$m" = "755" ]; then
    remember step4
    set_step 4 pass "hello.sh set to 755"
  elif seen step1 || owner_has hello.sh 1; then
    set_step 4 todo "set hello.sh to exactly 755" \
      "it's $m . Compare that to 755 digit by digit — which slots are short, and by how much?" \
      "chmod 755 hello.sh"
  else
    set_step 4 blocked "set hello.sh to 755"
  fi
fi

# --- Step 5: private/ directory, owner only -----------------------------
if [ -d private ]; then
  m=$(mode private)
  if [ "$m" = "700" ]; then
    remember step5
    set_step 5 pass "private/ created and locked to 700"
  else
    set_step 5 todo "lock private/ so only you can open it" \
      "it's $m . The last two slots need to go. Careful — on a directory, x is what lets you cd in, so keep yours" \
      "chmod 700 private"
  fi
else
  set_step 5 todo "create a directory called private/" \
    "create it first. Then look at what mkdir gave you by default" \
    "mkdir private && chmod 700 private"
fi

# --- render --------------------------------------------------------------
echo
echo -e "${BOLD}Level 05 — Permissions${NC}"
echo

missing=""
for f in hello.sh notes.txt secret.txt; do
  [ -f "$f" ] || missing="$missing $f"
done
if [ -n "$missing" ]; then
  echo -e "  ${RED}This level's starting files are missing:${NC}$missing"
  echo -e "  Run ${BOLD}./reset.sh${NC} to create them, then start over."
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
      $SHOW_CMD && [ -n "${CM[$i]}" ] && echo -e "      ${DIM}\$ ${CM[$i]}${NC}"
      next_shown=true ;;
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
  echo -e "  ${GREEN}${BOLD}Level 05 complete.${NC}"
  echo -e "  That is the last level — you made it through all five."
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
