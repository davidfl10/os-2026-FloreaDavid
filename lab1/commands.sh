#!/bin/bash
# Lab 1 - re-runs every non-interactive command of the lab, part by part.
# usage: bash commands.sh [work-dir]      (default: ~/os-lab1-rerun)
# top is run in batch mode (top -b -n 1); htop is interactive and is not included.
W="${1:-$HOME/os-lab1-rerun}"
mkdir -p "$W" && cd "$W" || exit 1
show() { echo; echo "\$ $*"; eval "$@"; }
part() { echo; echo "================ $* ================"; }

part "Setup"
show 'whoami'
show 'uname -a'
show 'uptime'

part "Part 1: files and directories"
show 'pwd'
show 'ls -la /'
show 'ls -la ~'
show '(cd /etc && ls | head)'
show 'mkdir -p demo && cd demo'
show 'echo "hello operating systems" > note.txt'
show 'cp note.txt copy.txt'
show 'mv copy.txt renamed.txt'
show 'ls -l'
show 'rm renamed.txt'
show 'ls -l note.txt'
show 'chmod 600 note.txt ; ls -l note.txt'
show 'chmod 644 note.txt ; ls -l note.txt'
show 'id'
cd "$W"

part "Part 2: processes"
show 'ps aux | head'
show 'ps aux | wc -l'
show 'top -b -n 1 | head -30'
set -m
show 'sleep 300 &'
show 'jobs -l'
show 'ps -ef | grep "[s]leep 300"'
show 'kill %1 ; sleep 0.2 ; jobs -l'
sleep 300 & PID=$!
echo; echo "\$ sleep 300 & PID=\$!      # PID=$PID"
show 'ls /proc/$PID/'
show 'cat /proc/$PID/status | head -20'
show 'kill $PID'
set +m
show 'ps -p 1 -o pid,user,comm,args'
show 'ls -l /sbin/init'

part "Part 3: memory"
show 'free -h'
show 'cat /proc/meminfo | head -6'
sleep 300 & PID=$!
echo; echo "\$ sleep 300 & PID=\$!      # PID=$PID"
show 'grep VmRSS /proc/$PID/status'
show 'grep -E "VmSize|RssAnon|RssFile|RssShmem" /proc/$PID/status'
show 'kill $PID'
show 'swapon --show'

part "Part 4: devices and storage"
show 'df -h'
show 'lsblk'
show 'du -sh "$W"'
show 'ls -l /dev | head'
show 'mount | head'
show 'findmnt /'
show 'ls -l /dev/null /dev/sda /dev/tty /dev/urandom'

part "Optional: strace"
if command -v strace >/dev/null; then
  show 'strace -c ls'
  show 'strace ls 2>&1 | tail -15'
else
  echo "strace is not installed"
fi

echo; echo "All parts done."
