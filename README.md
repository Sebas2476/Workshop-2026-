# Linux Command Line Workshop

Five hands-on levels. You'll spend the whole hour in the terminal.

Nothing here can break your computer. Every level can be reset.

## Start here

Open the terminal (**Terminal → New Terminal**, or `` Ctrl+` ``) and run:

```bash
cd levels-01-Orientation
cat task-01.md
```

Read the task, do it in the terminal, then run the level's script to check your work.

## The levels

| # | Folder | What you'll learn | Check with |
|---|--------|-------------------|------------|
| 1 | `levels-01-Orientation` | `pwd`, `whoami`, making a file | `./check.sh` |
| 2 | `levels-02-Navigation` | `ls`, `cd`, moving around | `./check.sh` |
| 3 | `levels-03-Readingfiles` | `head`, `tail`, `wc -l`, `grep` | `./test.sh` |
| 4 | `levels-04-Creating-and-modifying` | `mkdir`, `touch`, `cp`, `mv`, `rm` | `./test.sh` |
| 5 | `levels-05-Permissions` | `chmod`, `ls -l`, octal permissions | `./test.sh` |

Do them in order — each one builds on the last.

## If you get stuck

Levels 4 and 5 will show you the exact command:

```bash
./test.sh --hint
```

Levels 4 and 5 can also be restarted from scratch:

```bash
./reset.sh
```

Lost in the filesystem? `pwd` tells you where you are. `cd ~` takes you home.

## Reading the task files

Each level has a `task-NN.md`. Read it in the terminal with `cat`, or click it in
the file list on the left to open it in the editor. Either works.

## Notes

- Everything runs inside your own Codespace. Nothing you do affects anyone else.
- If your environment gets into a state you can't fix, rebuild the container
  (**Ctrl+Shift+P** → *Codespaces: Rebuild Container*) for a clean start.
- Please **stop your Codespace** when the workshop ends so it doesn't keep running.
