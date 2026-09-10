# Level 02 — Movement

Level 1 showed you where you are. This one is about leaving.

The filesystem is a tree of folders inside folders. `cd` moves you through it.

`cd folder` goes down into a folder.
`cd ..` goes up to the one containing you.

That's the whole idea.

## Look before you move

You can't `cd` into a folder you didn't know was there:

`ls` and see whats there, `cd ` to the dir to move into it 

And if `No such file or directory` means you typed a name that isn't there. Run `ls` and check.

## Press TAB

Type `cd and dont finish the file name`, press TAB. The shell finishes the word for you. Do this every time, it's where typos come from.

### YOUR TASK ############################ 

There's a `flag.txt` somewhere below this folder. Most paths are dead ends.

1. Find it using `ls` and `cd`.
2. Read it with `cat`.
3. Come back here and put the passphrase in `notes.txt`.

## Commands

| Command     | What it does                        |
|-------------|-------------------------------------|
| `ls`        | list what's in this folder          |
| `cd folder` | move into `folder`                  |
| `cd ..`     | move up one level                   |
| `pwd`       | print where you are                 |
| `cat f`     | print the contents of file `f`      |

Lost? `pwd` tells you where you are, `cd ..` walks you back. Nothing you do with `cd` can break anything.
