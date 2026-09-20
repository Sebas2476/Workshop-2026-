# Level 05 — Permissions

Every file decides who can read it, write to it, and run it.

You already changed these once. `chmod +x test.sh` in the last level was you
flipping a permission bit.

Run `ls -l` and look at the first column.

## Your task

1. Create `hello.sh` script and run `./hello.sh`. It fails. Make it executable, then run it again.
2. `notes.txt` is read-only. Make it writable and add a line to it.
3. Lock down `secret.txt` so only you can read or write it.
4. Set `hello.sh` to exactly `755` using octal.
5. Create a directory called `private/` that only you can open.

## Commands

| Command          | What it does                     |
|------------------|----------------------------------|
| `ls -l`          | show permissions for each file   |
| `stat -c %a f`   | show permissions as octal        |
| `chmod +x f`     | add execute for everyone         |
| `chmod +w f`     | add write for everyone           |
| `chmod u+rw f`   | add read and write for the owner |
| `chmod go-rwx f` | strip all access from others     |
| `chmod 644 f`    | set exact permissions, octal     |

In `ls -l`, the first column reads in threes: owner, group, everyone else.

`r` is 4, `w` is 2, `x` is 1. Add them per slot: `rwx` is 7, `rw-` is 6, `r--` is 4.

Run `ls -l` before every `chmod`. That's the habit.
