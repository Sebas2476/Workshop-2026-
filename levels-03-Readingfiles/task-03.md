# Level 03 — Reading Files

`server.log` has 300 lines in it. Try `cat server.log` and watch it scroll off the
screen. Nothing broke — `cat` did exactly what you asked. It just isn't the right
tool for a file this size.

Check the size of a file before you `cat` it. That's the habit.

## Your task

Two passphrases are hidden in the log. Each one needs a different tool.

1. Count how many lines the file has with `wc -l`.
2. Read the last few lines with `tail`. One passphrase is there.
3. The other one is buried in the middle. `grep` is the only way you'll find it —
   search the log for the word `passphrase`.
4. Create `answers.txt` and put both passphrases in it, one per line.

## Commands

| Command             | What it does                         |
|---------------------|--------------------------------------|
| `cat f`             | print the whole file                 |
| `head f`            | first 10 lines                       |
| `tail f`            | last 10 lines                        |
| `head -n 3 f`       | first 3 lines                        |
| `tail -n 20 f`      | last 20 lines                        |
| `wc -l f`           | count the lines                      |
| `grep word f`       | print every line containing `word`   |
| `grep -i word f`    | same, ignoring upper/lower case      |
| `grep -n word f`    | same, with line numbers              |

Once you've found them, try `grep ERROR server.log` to see every failure the
server recorded, and `grep -c ERROR server.log` to count them.

## Submit

```bash
./test.sh
```
