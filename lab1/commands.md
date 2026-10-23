# Lab 1 – All commands, in the order they were run

Working directory: `~/os-lab1`. The full transcript of every part (each command followed by its real
output) is in `outputs/`, one log per part. `commands.sh` re-runs everything that is not interactive.

## Setup (`outputs/lab1_part0_setup.log`)
| Command | What it does |
|---|---|
| `mkdir -p ~/os-lab1 && cd ~/os-lab1` | Create and enter the lab folder |
| `whoami` | Who I am to the OS (david) |
| `uname -a` | Which kernel manages the machine (Linux 7.0.0-38-generic, x86_64) |
| `uptime` | How long the OS has been running, and the load |

## Part 1 – Files and directories (`outputs/lab1_part1_files.log`)
| Command | What it does |
|---|---|
| `pwd` | Print the current directory |
| `ls -la /` | The root of the tree, with hidden entries and details (bin, lib, sbin are links into /usr) |
| `ls -la ~` | My home directory |
| `cd /etc && ls \| head` | The first entries of the configuration directory |
| `cd ~/os-lab1` | Back to the lab folder |
| `mkdir demo && cd demo` | Create a directory and enter it |
| `echo "hello operating systems" > note.txt` | Create a file with one line (kept in `generated/demo/note.txt`) |
| `cp note.txt copy.txt` | Copy a file |
| `mv copy.txt renamed.txt` | Rename (move) a file |
| `ls -l` | List with owner, group, permissions, size |
| `rm renamed.txt` | Remove a file |
| `ls -l note.txt` | Read the rwx / owner / group columns |
| `chmod 600 note.txt` | Owner-only read and write: `-rw-------` |
| `chmod 644 note.txt` | Everyone may read, only the owner writes: `-rw-r--r--` |
| `id` | My user and group IDs (uid=1000(david) gid=1000(david)) |

## Part 2 – Processes (`outputs/lab1_part2_processes.log`)
| Command | What it does |
|---|---|
| `ps aux \| head` | The first processes, with user, PID, CPU, memory |
| `ps aux \| wc -l` | How many processes exist (minus 1 for the header) |
| `top -b -n 1 \| head -30` | One snapshot of top (batch mode, instead of the interactive `top` + q) |
| `sleep 300 &` | Start a background process |
| `jobs -l` | The shell's background jobs, with PIDs |
| `ps -ef \| grep sleep` | Find it among all processes |
| `kill <PID>` | Ask the OS to terminate it (SIGTERM) |
| `sleep 300 & PID=$!` | Start another one and keep its PID |
| `ls /proc/$PID/` | What the kernel exposes about the process |
| `cat /proc/$PID/status \| head -20` | Its name, state (S = sleeping), PIDs, memory |
| `kill $PID` | Stop it |
| `ps -p 1 -o pid,user,comm,args` | PID 1 = systemd, the init process |
| `ls -l /sbin/init` | /sbin/init is a link to systemd |

## Part 3 – Memory (`outputs/lab1_part3_memory.log`)
| Command | What it does |
|---|---|
| `free -h` | Total, used, free and available RAM and swap |
| `cat /proc/meminfo \| head -6` | The kernel's own memory counters |
| `sleep 300 & PID=$!` | A process to inspect |
| `grep VmRSS /proc/$PID/status` | Its resident (real) memory |
| `grep -E "VmSize\|RssAnon\|RssFile\|RssShmem" /proc/$PID/status` | Virtual size vs. private and shared resident memory |
| `kill $PID` | Stop it |
| `swapon --show` | The swap area (the file /swap.img) |

## Part 4 – Devices and storage (`outputs/lab1_part4_devices.log`)
| Command | What it does |
|---|---|
| `df -h` | Mounted file systems and how full they are |
| `lsblk` | Disks and partitions (sda → sda1, sda2) |
| `du -sh ~/os-lab1` | Disk space used by the lab folder |
| `ls -l /dev \| head` | Device files (c = character, b = block) |
| `mount \| head` | What is mounted where |
| `findmnt /` | The root file system: /dev/sda2, ext4 |
| `ls -l /dev/null /dev/sda /dev/tty /dev/urandom` | Some devices and their major/minor numbers |

## Optional – htop and strace (`outputs/lab1_optional_htop_strace.log`)
| Command | What it does |
|---|---|
| `htop --version` | Check that htop is installed |
| `screen -dmS htopcap bash -c "TERM=xterm htop"; sleep 3; screen -S htopcap -X hardcopy /tmp/htop.txt; screen -S htopcap -X quit` | htop is interactive: run it in a detached screen and save one screen of it (normally you just run `htop` and press q) |
| `strace -c ls` | Count the system calls made by ls |
| `strace ls 2>&1 \| tail -15` | The last system calls of ls (openat, getdents64, write, exit_group) |
