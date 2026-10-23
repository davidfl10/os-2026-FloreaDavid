#!/bin/bash
# Lab 5 - re-runs every command of the lab, part by part (as a normal user, not root).
# usage: bash commands.sh [work-dir]      (default: ~/os-lab5-rerun)
# Stretch task (d) needs sudo and is not included (see commands.md).
W="${1:-$HOME/os-lab5-rerun}"
if [ "$(id -u)" -eq 0 ]; then echo "run this as a normal user, not root" >&2; exit 1; fi
if [ -e "$W" ] && [ -n "$(ls -A "$W")" ]; then
  echo "$W is not empty - give an empty or new folder" >&2; exit 1
fi
mkdir -p "$W" && cd "$W" || exit 1
show() { echo; echo "\$ $*"; eval "$@"; }
part() { echo; echo "================ $* ================"; }

part "Before you start"
show 'whoami'

part "Part 1: the tree and the file types"
show 'ls /'
show 'ls -ld /etc /etc/passwd /bin /dev/null /tmp'
show 'ls -l /dev | head'
show 'ls -l /dev | grep "^b" | head -4'
show 'file /usr/bin/ls /etc/passwd /bin'
show 'du -sh /var/log 2>/dev/null ; du -sh /usr 2>/dev/null'

part "Part 2: inodes and links"
show 'echo hello > notes.txt'
show 'stat notes.txt'
show 'ls -li notes.txt'
show 'ln notes.txt hard.txt'
show 'ls -li notes.txt hard.txt'
show 'rm notes.txt'
show 'cat hard.txt ; ls -li hard.txt'
show 'ln -s hard.txt soft.txt'
show 'ls -li hard.txt soft.txt'
show 'cat soft.txt'
show 'rm hard.txt'
show 'cat soft.txt ; ls -l soft.txt'
show 'mkdir d ; ls -ld d'
show 'mkdir d/x d/y ; ls -ld d'
show 'ls -lai d'
show 'echo x > one.txt ; ls -l one.txt ; du -h one.txt'
show 'truncate -s 1G big.img ; ls -lh big.img ; du -h big.img'
show 'stat -c "%n: size %s bytes, %b blocks of %B bytes" one.txt big.img'
show 'rm big.img'

part "Part 3: permissions"
show 'echo secret > s.txt'
show 'chmod 600 s.txt ; ls -l s.txt'
show 'chmod 000 s.txt ; cat s.txt'
show 'chmod u+r s.txt ; cat s.txt'
show 'umask ; touch new.txt ; mkdir newdir ; ls -ld new.txt newdir'
show 'umask -S'
show 'mkdir box ; echo hi > box/f'
show 'chmod u=r,go= box  ; ls box ; cat box/f     # read only'
show 'chmod u=x,go= box  ; ls box ; cat box/f     # execute only'
show 'chmod 755 box ; ls -ld box'
show 'ls -l /usr/bin/passwd ; ls -ld /tmp'
show 'cat /etc/shadow'
show 'ls -l /etc/shadow'

part "Part 4: disks and the kernel as files"
show 'lsblk'
show 'df -h'
show 'mount | grep " / "'
show 'grep -c processor /proc/cpuinfo'
show 'head -3 /proc/meminfo'
show 'head -5 /proc/self/status'
show 'ls -l /proc/self/fd'

part "Stretch (a): magic numbers"
show 'gzip -c /etc/passwd > notes.txt ; file notes.txt ; xxd notes.txt | head -1'
show 'readlink -f /usr/bin/ls ; xxd -l 16 $(readlink -f /usr/bin/ls)'
show 'file -L /usr/bin/ls | cut -c1-90'

part "Stretch (b): setuid programs"
show 'find / -xdev -perm -4000 -type f 2>/dev/null'

part "Stretch (c): a deleted file that is still open (writes 100 MB)"
show 'dd if=/dev/zero of=bigfile bs=1M count=100 status=none ; df -m . | tail -1'
show 'exec 3< bigfile ; rm bigfile ; ls -l /proc/$$/fd'
show 'df -m . | tail -1'
show 'exec 3<&- ; ls -l /proc/$$/fd ; df -m . | tail -1'

echo; echo "All parts done. Files left in $W"
