---
layout: single
---

## Gives info about the file system
```
df -h .
```
Lists all disks any their usages. Give a great overview about your used diskspace


## Detailed info about disk usage
```
du ./* -s -h
```
Lists the items and their disk-usages within the folder you have opened. 

```
du -h . | sort -hr | head
```
Sorts by filesize.

```
du -s -h ./* | sort -nrk 1
```

## Run process in background
And forward output to file
```
nohup ./program > Output.log 2>&1 & 
echo $! > save_pid.txt
```

Or just store the pid
```
nohup ./programm & print $! >> my_server.pid
```

## compress a folder
```
tar -z v c f
``` 
z: gzip (This will compress your .tar archive) 
v: verbose (So you can see which files actually went into the archive.
c: create (define a name for the tar.gz file)
f: filenames or directory to add into the archive. 

Example: 
tar -czvf name-of-archive.tar.gz /path/to/directory-or-file

## Uncompress an archive
```
tar -z x v f (use gZip, eXtract, verbose, file)
```

## Create a file

```
touch file.txt
```
## Copy clipboard into file on linux
Overwrite content with clipoard:
1. cat > file
2. paste (right click)
3. Maybe an enter
4. CTRL + D (EOF)
	
Append clipboard to file
1. cat >> file
2. paste (right click)
3. Maybe an enter
4. CTRL + D (EOF)


## Read file
* head file.txt
* tail file.txt
* cat file.txt (prints out the whole file at once)
* more file.txt (by enter you can scroll through the file)

## Write to file
### Using echo
* echo "my text" > file.txt (overwrites the file)
* echo "my text" >> file.txt (appends to the file)

If your text contains itself double quotes, you can use single quotes to wrap the text:
* echo 'He said: "Hello World"' >> file.txt



## Vim basics

Open (or create) a file with vim:
```
vim file.txt
```

Vim has two main modes:
- **Normal mode** — navigate and run commands (this is where you start)
- **Insert mode** — type text

### Write content to a file

1. Open the file: `vim file.txt`
2. Press `i` to enter **Insert mode** (you'll see `-- INSERT --` at the bottom)
3. Type your text
4. Press `Esc` to go back to **Normal mode**
5. Type `:w` and hit `Enter` to **save**

### Undo and redo
Vim does **not** use `Ctrl+Z` for undo. Make sure you are in **Normal mode** first (`Esc`), then:

| Command | What it does |
|---------|--------------|
| `u` | Undo last change |
| `Ctrl+r` | Redo (undo the undo) |
| `5u` | Undo the last 5 changes |

> `Ctrl+Z` in vim suspends the process to the background instead — not what you want!

### Save and quit
| Command | What it does |
|---------|--------------|
| `:w` | Save (write) |
| `:q` | Quit (only works if no unsaved changes) |
| `:wq` | Save and quit |
| `:q!` | Quit **without** saving (force) |

### Quick example
```
vim notes.txt   # open file
i               # enter Insert mode
Hello World     # type something
Esc             # back to Normal mode
:wq             # save and quit
```

## VI paste mode
If you don't want Vim to mangle formatting in incoming pasted text, you want to consider using: ```:set paste ``` This will prevent vim from re-tabbing your code. When done pasting, ```:set nopaste``` will return to the normal behavior.

## Grep a file
$ grep -C 5 "My error message" error.log