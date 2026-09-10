# Level 03 — Reading Files

Some files are too long to read all at once. `server.log` has 300 lines.

Try `cat server.log` first. Watch what happens.

Then use the right tool.

## Your task

1. Run `cat server.log` and see why it doesn't work.
2. Count how many lines the file has.
3. Read the last few lines and find the passphrase.
4. Put it in `notes.txt`.

## Commands

| Command      | What it does           |
|--------------|------------------------|
| `cat f`      | print the whole file   |
| `head f`     | first 10 lines         |
| `tail f`     | last 10 lines          |
| `head -n 3 f`| first 3 lines          |
| `tail -n 3 f`| last 3 lines           |
| `wc -l f`    | count the lines        |

Check the size with `wc -l` before you `cat` anything. That's the habit.
