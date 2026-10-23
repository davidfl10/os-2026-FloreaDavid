# Lab 1 – The OS as a Resource Manager

**Florea David, FAF-242** · Track A (Linux) · 2026-10-05

Machine: `Linux david-VirtualBox 7.0.0-38-generic #38-Ubuntu SMP PREEMPT_DYNAMIC x86_64` (Ubuntu 26.04.1 LTS in VirtualBox), user `david`, up 1 h 28 min at the start of the lab.
Full command transcripts are in `logs/lab1_*.log`.

---

## Part 1 – Files and directories

**(1) Owner and group.** The files I created (`note.txt`, `renamed.txt`) are owned by user **david** and group **david**. On Ubuntu every user gets a private group with the same name (`id` → `uid=1000(david) gid=1000(david)`).

**(2) The ten characters after `chmod 600`.** `ls -l note.txt` printed `-rw-------`:

| chars | meaning |
|---|---|
| `-` | file type: regular file (`d` = directory, `l` = symlink, `c`/`b` = device) |
| `rw-` | owner (david) may read and write but not execute |
| `---` | group (david) gets no access |
| `---` | others get no access |

So after `chmod 600` only I can read or modify the file. After `chmod 644` it became `-rw-r--r--`: everyone can read it but only I can write it.

**(3) Two directories under `/`:**
- `/etc` holds system-wide configuration files (e.g. `adduser.conf`, `NetworkManager/`, `X11/`).
- `/home` holds the users' personal home directories (here `/home/david`).
- (Bonus) `/proc` is not on disk at all. It's a virtual filesystem the kernel generates, with one directory per running process. Its size shows as `0` in `ls -la /`.

**Interesting output:** on this Ubuntu `/bin`, `/lib` and `/sbin` are just symlinks into `/usr` (the "merged /usr" layout):
```
lrwxrwxrwx   1 root root          7 Apr 20 11:46 bin -> usr/bin
lrwxrwxrwx   1 root root          7 Apr 20 11:46 lib -> usr/lib
lrwxrwxrwx   1 root root          8 Apr 20 11:46 sbin -> usr/sbin
-rw-------   1 root root 3530555392 Oct  5 12:15 swap.img
```

## Part 2 – Processes

**(1) PID 1.** PID 1 is **systemd** (`/usr/lib/systemd/systemd --switched-root --system ...`, run by root; `/sbin/init -> ../lib/systemd/systemd`). It's the first user-space process the kernel starts at boot (the *init* process). It starts and supervises all the system services, and it adopts orphaned processes. PID 2 is `kthreadd`, the parent of all kernel threads.

**(2) Number of processes.** `ps aux | wc -l` returned **240–241**. Subtracting the header line, about **239 processes** were running on the "idle" VM. `top` agreed: `Tasks: 239 total, 1 running, 237 sleeping, 0 stopped, 1 zombie`. Most of them are kernel threads (`[kworker/...]`, `[rcu_...]`) and GNOME desktop processes.

**(3) State of the sleeping process.** `/proc/<pid>/status` showed `State: S (sleeping)`. `sleep 300` isn't using the CPU. It's blocked in the kernel waiting for a timer to expire, so the scheduler doesn't run it until then.

**Interesting output:** the full lifecycle of a background job:
```
$ sleep 300 &
[1] 11339
$ ps -ef | grep sleep
david      11339   11331  0 14:13 ?        00:00:00 sleep 300
$ kill 11339
$ jobs -l
[1]+ 11339 Terminated                 sleep 300
```
`kill` doesn't kill anything by itself. It asks the kernel to deliver signal 15 (SIGTERM), and the kernel then terminates the process.

## Part 3 – Memory

**(1) Total and free RAM.** `free -h`: **3.3 GiB total** (MemTotal 3 480 328 kB), 1.8 GiB used, **209 MiB "free"** but **1.5 GiB "available"**. "Free" is low because Linux uses otherwise idle RAM as page cache (`buff/cache` 1.5 GiB). That cache is released when programs need memory, so "available" is the real headroom.

**(2) Swap.** Swap is disk space the kernel uses as an overflow for RAM: rarely used memory pages are moved out to disk to make room in physical memory. This VM has a **3.3 GiB swap file** (`/swap.img`, not a partition), of which about 978 MiB was in use. The VM is fairly memory-constrained with a desktop running.

**(3) VmRSS of `sleep`.** `VmRSS: 7740 kB` (about 7.6 MB), while the virtual size was `VmSize: 16116 kB`. That surprised me for a program that does nothing. The breakdown explains it: `RssAnon: 1224 kB` (its own private memory) and `RssFile: 6516 kB` (mapped files, mostly the C library `libc.so` and the `sleep` binary). Those file pages are **shared** with every other process using libc, so `sleep` only costs about 1.2 MB of extra RAM.

*Side observation:* when I first read `VmRSS` immediately after `sleep 300 &`, I got `1012 kB`. The process hadn't finished `exec`-ing `sleep` yet, so I was measuring a half-started process. Pausing for 1 s gave the stable value above.

## Part 4 – Devices and storage

**(1) Root filesystem device.** `/` is mounted from **`/dev/sda2`**, an **ext4** partition of 20 GB (12 GB used, 60%). `lsblk` shows that `sda` is the VM's single 20 GB virtual disk, with `sda1` a tiny 1 MB BIOS-boot partition and `sda2` the root.

**(2) A `/dev` entry.**
- `/dev/sda` (`brw-rw---- root disk 8, 0`) is the whole virtual hard disk. `b` = block device, major 8 = SCSI/SATA disk driver.
- `/dev/null` (`crw-rw-rw- 1, 3`) is a character device that discards anything written to it.
- `/dev/sr0` (also `/dev/cdrom`) is the virtual CD drive, currently holding the VirtualBox Guest Additions ISO.

**(3) "Everything is a file".** Disks, terminals, the CD-ROM, even random numbers (`/dev/urandom`) and process information (`/proc`) are all exposed as entries in the same directory tree. Programs use them through the same `open/read/write/close` calls they use for ordinary files, and the kernel's drivers do the device-specific work behind that interface.

**Interesting output:** `df -h` shows that several "filesystems" don't live on any disk at all. They are RAM-backed (`tmpfs`):
```
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           680M  2.4M  678M   1% /run
/dev/sda2        20G   12G  7.5G  60% /
tmpfs           1.7G  5.0M  1.7G   1% /tmp
/dev/sr0         51M   51M     0 100% /run/media/david/VBox_GAs_7.2.20
```

## Optional – htop and strace

`htop 3.4.1` shows the same data as `top`, but with per-CPU bars (2 vCPUs here), memory/swap bars, and a scrollable process list sorted by CPU (captured screen in the log).

`strace -c ls` (in a directory containing only `demo/`) made **138 system calls (12 of them failed)** just to print one word:
- `mmap` ×27, `openat` ×11, `read` ×14, `mprotect` ×8 load the program and its shared libraries into memory
- `getdents64` ×2 is the call that actually reads the directory entries
- `write` ×1 prints `demo\n` to stdout
- `execve` ×1 starts the program; `exit_group` ends it
- the 7 failed `ioctl` calls are `ls` checking whether stdout is a terminal (it wasn't: `ENOTTY`)

So almost all of the work is setup. The "real" job of `ls` comes down to `openat` + `getdents64` + `write`, and every one of those is a request to the kernel.

---

## Conclusion

The OS manages **files**: `ls -l` and `chmod` showed it naming data in one tree and enforcing who may read or write each file. It manages **processes**: `ps aux` / `top` revealed about 239 processes it creates, schedules and signals (`kill`), all visible under `/proc`. It manages **memory** and **devices/I/O**: `free -h` and `VmRSS` showed it splitting 3.3 GiB of RAM (plus swap) between processes, and `df -h`, `lsblk` and `ls -l /dev` showed it hiding the disk and other hardware behind file-like interfaces.
