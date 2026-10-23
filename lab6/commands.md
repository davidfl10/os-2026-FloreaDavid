# Lab 6 – All commands, in the order they were run

`bash$` = typed in the Linux terminal (in `~/xv6-riscv`), `xv6$` = typed at the xv6 prompt after `make qemu`.
Leave xv6 with **Ctrl-A, then X**. The real output of every figure is in `outputs/`, the screenshots in `screenshots/`.

## Before you start
```bash
bash$ bash os2026-setup.sh --check          # toolchain, QEMU and ~/xv6-riscv are ready
bash$ cd ~/xv6-riscv
```
New programs (both in this folder): `user/mystat.c` and `user/find.c`, added to UPROGS:
```makefile
	$U/_mystat\
	$U/_find\
```

## Part 1 – Read what xv6 shows you (Figures 1.1–1.2)
```bash
bash$ make clean ; make qemu                # fresh disk
xv6$ ls                                     # name, type, inode, size
xv6$ mkdir a
xv6$ ls a                                   # . (inode 29) and .. (inode 1), 16 bytes each
bash$ cat kernel/stat.h                     # T_DIR 1, T_FILE 2, T_DEVICE 3, struct stat
bash$ grep -n -A3 "^struct dirent" kernel/fs.h ; grep -n "define DIRSIZ" kernel/fs.h
```

## Part 2 – mystat and hard links (Figures 2.1–2.4)
```bash
bash$ cat user/mystat.c
xv6$ mystat README . console                # file/directory/device, inode, links, size
xv6$ mystat a nosuchfile                    # error on fd 2, then continues
xv6$ ln README r2                           # second name for inode 2
xv6$ mystat README r2                       # both: inode 2, links 2
xv6$ rm README
xv6$ mystat r2                              # inode 2, links 1, same size
xv6$ cat r2 | wc                            # 48 336 2441 -> the data survived
bash$ sed -n '242,248p' kernel/sysfile.c    # sys_unlink: ip->nlink--;
bash$ sed -n '353,366p' kernel/fs.c         # iput: itrunc() frees the blocks when ref==1 && nlink==0
bash$ sed -n '/^struct dinode/,/^};/p' kernel/fs.h    # the on-disk inode fields
```

## Part 3 – Measure the limits (Figures 3.1–3.2)
```bash
bash$ grep -n "define BSIZE\|define NDIRECT\|define NINDIRECT\|define DIRSIZ" kernel/fs.h
bash$ make clean ; make fs.img 2>&1 | grep nmeta     # 2000 blocks: 47 metadata, 1953 data
bash$ make qemu
xv6$ mkdir averyveryverylongname
xv6$ ls                                              # shown as averyveryveryl (DIRSIZ = 14)
xv6$ mystat averyveryverylongname averyveryveryl     # the same inode 30
```
Largest file: (NDIRECT + BSIZE/4) × BSIZE = (12 + 256) × 1024 = 274 432 bytes.

## Part 4 – find (Figures 4.1–4.3)
```bash
bash$ grep -n -A9 '^UPROGS' Makefile
bash$ make user/_find user/_mystat && ls -l user/_find user/_mystat
bash$ make clean ; make qemu                # fresh disk for the test
xv6$ mkdir a
xv6$ mkdir a/b
xv6$ echo x > a/b/r2
xv6$ echo y > a/r2
xv6$ ln cat r2
xv6$ find . r2                              # ./a/b/r2  ./a/r2  ./r2
xv6$ find a b                               # a/b
xv6$ find . nothing                         # prints nothing
xv6$ find README r2                         # find: README is not a directory
xv6$ find . r2 -n                           # stretch: with inode numbers (31, 32, 3)
xv6$ find . cat -n                          # ./cat 3 -> ./r2 is the same file as cat
xv6$ mystat cat r2 a/r2 a/b/r2
```

## Deliverables (copied into this folder)
```bash
mkdir -p ~/os-2026-FloreaDavid/lab6
cp ~/xv6-riscv/user/mystat.c ~/xv6-riscv/user/find.c ~/xv6-riscv/Makefile ~/os-2026-FloreaDavid/lab6/
```
