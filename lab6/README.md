# Lab 6 – Inside the xv6 File System

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

The xv6 programs live in `~/xv6-riscv/user/`; to use them, copy them there, keep the UPROGS lines of the Makefile, and run `make qemu`.

## What is in this folder

| File | What it is |
|---|---|
| `Lab6_FloreaDavid_FAF-242.docx` | the report (UTM format) |
| `mystat.c` | xv6 stat program: type, inode, links, size (Part 2) |
| `find.c` | recursive find <dir> <name> [-n] (Part 4 + stretch) |
| `Makefile` | xv6 Makefile with the UPROGS lines |
| `commands.md` | every command, in the order it was run, grouped by part |
| `screenshots/` | every figure of the report, as PNG |
| `outputs/` | the real terminal output of every figure, as text |

## Figures

| Figure | Caption | Screenshot | Output |
|---|---|---|---|
| 1.1 | ls in the root directory and in the new directory a | `screenshots/fig1.1_ls-in-the-root-directory-and-in-the-new-directory-a.png` | `outputs/fig1.1_ls-in-the-root-directory-and-in-the-new-directory-a.txt` |
| 1.2 | kernel/stat.h and the directory entry in kernel/fs.h | `screenshots/fig1.2_kernel-stat-h-and-the-directory-entry-in-kernel-fs-h.png` | `outputs/fig1.2_kernel-stat-h-and-the-directory-entry-in-kernel-fs-h.txt` |
| 2.1 | user/mystat.c | `screenshots/fig2.1_user-mystat-c.png` | `outputs/fig2.1_user-mystat-c.txt` |
| 2.2 | mystat watching a hard link at work | `screenshots/fig2.2_mystat-watching-a-hard-link-at-work.png` | `outputs/fig2.2_mystat-watching-a-hard-link-at-work.txt` |
| 2.3 | The decrement in sys_unlink and the freeing of blocks in iput | `screenshots/fig2.3_the-decrement-in-sys-unlink-and-the-freeing-of-blocks-in-ipu.png` | `outputs/fig2.3_the-decrement-in-sys-unlink-and-the-freeing-of-blocks-in-ipu.txt` |
| 2.4 | struct dinode – the on-disk inode of xv6 | `screenshots/fig2.4_struct-dinode-the-on-disk-inode-of-xv6.png` | `outputs/fig2.4_struct-dinode-the-on-disk-inode-of-xv6.txt` |
| 3.1 | The constants in fs.h and the nmeta line printed by mkfs | `screenshots/fig3.1_the-constants-in-fs-h-and-the-nmeta-line-printed-by-mkfs.png` | `outputs/fig3.1_the-constants-in-fs-h-and-the-nmeta-line-printed-by-mkfs.txt` |
| 3.2 | A name longer than DIRSIZ | `screenshots/fig3.2_a-name-longer-than-dirsiz.png` | `outputs/fig3.2_a-name-longer-than-dirsiz.txt` |
| 4.1 | UPROGS with mystat and find, and building them | `screenshots/fig4.1_uprogs-with-mystat-and-find-and-building-them.png` | `outputs/fig4.1_uprogs-with-mystat-and-find-and-building-them.txt` |
| 4.2 | find on a fresh disk | `screenshots/fig4.2_find-on-a-fresh-disk.png` | `outputs/fig4.2_find-on-a-fresh-disk.txt` |
| 4.3 | find . r2 -n: which r2 is the same file as cat | `screenshots/fig4.3_find-r2-n-which-r2-is-the-same-file-as-cat.png` | `outputs/fig4.3_find-r2-n-which-r2-is-the-same-file-as-cat.txt` |
