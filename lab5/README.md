# Lab 5 – The File System with Your Own Hands (Linux)

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

All commands were run on Ubuntu 26.04 (VirtualBox VM) as the normal user david.

## What is in this folder

| File | What it is |
|---|---|
| `Lab5_FloreaDavid_FAF-242.docx` | the report (UTM format) |
| `commands.sh` | re-runs every command (stretch d excluded): `bash commands.sh [empty-folder]` |
| `generated/` | what the experiments left in ~/os-lab5: box/, d/, newdir/, s.txt, one.txt, notes.txt (gzip), soft.txt (dangling symlink) |
| `commands.md` | every command, in the order it was run, grouped by part |
| `screenshots/` | every figure of the report, as PNG |
| `outputs/` | the real terminal output of every figure, as text |

## Figures

| Figure | Caption | Screenshot | Output |
|---|---|---|---|
| 1.1 | The root directory and the types of five paths | `screenshots/fig1.1_the-root-directory-and-the-types-of-five-paths.png` | `outputs/fig1.1_the-root-directory-and-the-types-of-five-paths.txt` |
| 1.2 | Devices in /dev (character and block devices) | `screenshots/fig1.2_devices-in-dev-character-and-block-devices.png` | `outputs/fig1.2_devices-in-dev-character-and-block-devices.txt` |
| 1.3 | file and du | `screenshots/fig1.3_file-and-du.png` | `outputs/fig1.3_file-and-du.txt` |
| 2.1 | stat and ls -li: the inode of notes.txt | `screenshots/fig2.1_stat-and-ls-li-the-inode-of-notes-txt.png` | `outputs/fig2.1_stat-and-ls-li-the-inode-of-notes-txt.txt` |
| 2.2 | A hard link, then removing the “original” | `screenshots/fig2.2_a-hard-link-then-removing-the-original.png` | `outputs/fig2.2_a-hard-link-then-removing-the-original.txt` |
| 2.3 | A symbolic link, then removing its target | `screenshots/fig2.3_a-symbolic-link-then-removing-its-target.png` | `outputs/fig2.3_a-symbolic-link-then-removing-its-target.txt` |
| 2.4 | Link count of a directory | `screenshots/fig2.4_link-count-of-a-directory.png` | `outputs/fig2.4_link-count-of-a-directory.txt` |
| 2.5 | Size is not space | `screenshots/fig2.5_size-is-not-space.png` | `outputs/fig2.5_size-is-not-space.txt` |
| 3.1 | File permissions: 600, 000 and u+r | `screenshots/fig3.1_file-permissions-600-000-and-u-r.png` | `outputs/fig3.1_file-permissions-600-000-and-u-r.txt` |
| 3.2 | The umask and the permissions of new files | `screenshots/fig3.2_the-umask-and-the-permissions-of-new-files.png` | `outputs/fig3.2_the-umask-and-the-permissions-of-new-files.txt` |
| 3.3 | The box experiment: r and x on a directory | `screenshots/fig3.3_the-box-experiment-r-and-x-on-a-directory.png` | `outputs/fig3.3_the-box-experiment-r-and-x-on-a-directory.txt` |
| 3.4 | Special bits (s, t) and a file of another user | `screenshots/fig3.4_special-bits-s-t-and-a-file-of-another-user.png` | `outputs/fig3.4_special-bits-s-t-and-a-file-of-another-user.txt` |
| 4.1 | lsblk, df -h and the root mount | `screenshots/fig4.1_lsblk-df-h-and-the-root-mount.png` | `outputs/fig4.1_lsblk-df-h-and-the-root-mount.txt` |
| 4.2 | CPU, memory and the current process in /proc | `screenshots/fig4.2_cpu-memory-and-the-current-process-in-proc.png` | `outputs/fig4.2_cpu-memory-and-the-current-process-in-proc.txt` |
| 5.1 | Magic numbers of a gzip file and of an ELF program | `screenshots/fig5.1_magic-numbers-of-a-gzip-file-and-of-an-elf-program.png` | `outputs/fig5.1_magic-numbers-of-a-gzip-file-and-of-an-elf-program.txt` |
| 5.2 | setuid programs on the root file system | `screenshots/fig5.2_setuid-programs-on-the-root-file-system.png` | `outputs/fig5.2_setuid-programs-on-the-root-file-system.txt` |
| 5.3 | A deleted file that is still open keeps its space | `screenshots/fig5.3_a-deleted-file-that-is-still-open-keeps-its-space.png` | `outputs/fig5.3_a-deleted-file-that-is-still-open-keeps-its-space.txt` |
