# Level 04 — Creating and Modifying

So far you've only looked at things. Now you'll change them.

There is no Trash on the command line. `rm` deletes, and that's it.

Look before you delete.

## Your task

1. Create `archive` directory with `2026` directory inside it. (One command).
2. Create an empty file called `archive/scratch.txt`.
3. Copy `field-notes.txt` into `archive/2026/`.
4. Rename the copy to `notes-2026.txt`.
5. Delete `archive/scratch.txt`.

When you're done, `field-notes.txt` should still be where it started.
If it's gone, you moved it when you should have copied it.

## Commands

| Command        	| What it does                 |
|----------------	|------------------------------|
| `touch f`      	| create an empty file         |
| `mkdir d`      	| create a directory           |
| `mkdir -p dir[dir]` 	| create nested directories    |
| `cp f g`       	| copy a file                  |
| `cp -r d e`    	| copy a directory             |
| `mv f g`       	| rename a file                |
| `mv f d`       	| move a file into a directory |
| `rm f`         	| delete a file                |

`cp` needs `-r` for directories. `mv` doesn't.

Run `ls` on a path before you `rm` it. That's the habit
