#!/bin/bash
# Level 05 — reset to the starting state:  ./reset.sh
 
GREEN='\033[0;32m'; NC='\033[0m'
 
rm -rf private
rm -f greeting.txt .progress
 
cat > hello.sh << 'EOF'
#!/bin/bash
echo "It runs. You gave this file permission to execute."
echo "written by hello.sh" > greeting.txt
EOF
 
cat > notes.txt << 'EOF'
Permissions are set per file.
Three slots: owner, group, everyone else.
This file started out read-only.
EOF
 
cat > secret.txt << 'EOF'
Right now anyone on this machine can read this.
Fix that.
EOF
 
chmod 640 hello.sh     # readable, not executable
chmod 444 notes.txt    # read-only for everyone
chmod 644 secret.txt   # world-readable
 
echo -e "${GREEN}Level 05 reset.${NC} Run ./test.sh to start over."
 
