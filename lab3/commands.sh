#!/bin/bash
# Lab 3 - re-runs every non-interactive command of the lab, part by part.
# usage: bash commands.sh [work-dir]      (default: ~/os-lab3-rerun)
# Not included: Tab completion, Ctrl+R and man (interactive) and the cron bonus
# (it changes your crontab) - see commands.md for those.
HERE="$(cd "$(dirname "$0")" && pwd)"
W="${1:-$HOME/os-lab3-rerun}"
mkdir -p "$W" && cd "$W" || exit 1
cp "$HERE/oneliners.sh" "$HERE/report.sh" .
show() { echo; echo "\$ $*"; eval "$@"; }
part() { echo; echo "================ $* ================"; }

part "Setup: generate access.log"
for i in $(seq 1 500); do
  echo "2026-10-05 10:$(printf %02d $((i % 60))) user$((i % 7)) $([ $((i % 5)) -eq 0 ] && echo FAIL || echo OK) /page$((i % 4))"
done > access.log
show 'head -3 access.log ; wc -l access.log'

part "Part 1: built-ins, PATH, exit codes, help"
show 'type cd ; type ls ; type echo ; which ls'
show 'type -a ls echo'
show 'echo $PATH'
show "echo \$PATH | tr ':' '\n'"
show "echo \$PATH | tr ':' '\n' | wc -l"
show 'nosuchprog ; echo "exit code: $?"'
show 'ls --help | head'
show 'man -k "list directory"'
show 'help cd | head -12'

part "Part 2: what the shell does to the line"
mkdir -p play && cd play
show 'touch a.c b.c file1.txt file2.txt notes.txt "alfa beta.txt"'
show 'ls'
show 'echo *.c'
show 'echo file?.txt'
show 'echo [a-b]*'
show 'echo *.xyz'
show 'ls alfa beta.txt'
show 'ls "alfa beta.txt"'
show 'ls alfa\ beta.txt'
show "echo '\$HOME' \"\$HOME\" \\\$HOME"
show 'echo {1..5} ; echo $((7 * 6))'
show 'echo "today is $(date +%A), I am $(whoami)"'
show 'touch log{1..3}.txt && ls log*'
cd "$W"

part "Part 3: redirection, chaining, jobs"
show 'ls /etc /nope > out.txt 2> err.txt'
show 'wc -l out.txt ; cat err.txt'
show 'ls /etc /nope > all.txt 2>&1 ; tail -2 all.txt'
show 'head -2 all.txt ; wc -l all.txt'
show 'ls /etc /nope 2>&1 > all.txt'
show 'head -2 all.txt ; wc -l all.txt'
show 'echo first > notes.md ; echo second >> notes.md ; cat notes.md'
show 'wc -l < access.log'
show 'wc -l access.log'
show 'ls /nope 2> /dev/null || echo "failed with code $?"'
show 'mkdir -p tmp && cd tmp && echo "I am in $(pwd)" ; cd "$W"'
show 'false ; echo "; runs anyway"'
show 'false && echo "&& - not printed"'
show 'true || echo "|| - not printed"'
set -m                                 # job control, so that %1 works in a script
show 'sleep 100 &'
show 'jobs ; kill %1 ; sleep 0.2 ; jobs'
set +m

part "Part 4: one-liners"
show 'bash oneliners.sh'
show 'ls /etc | wc -l ; ls -l /etc | wc -l ; ls -l /etc | head -3'
show "grep -E '^[^ ]+ 10:[0-5]0 [^ ]+ FAIL' access.log | head -12"
show "grep -cE '^[^ ]+ 10:[0-5]0 [^ ]+ FAIL' access.log"

part "Part 5: report.sh"
show 'cat report.sh'
show 'chmod -x report.sh ; ./report.sh access.log'
show 'chmod +x report.sh ; ls -l report.sh'
show './report.sh access.log'
show './report.sh nope.log ; echo "exit code: $?"'
show './report.sh nope.log 2> /dev/null ; echo "exit code: $?"'
show 'report.sh access.log'

echo; echo "All parts done."
