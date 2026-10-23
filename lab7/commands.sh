#!/bin/bash
# Lab 7 - compiles and runs every program of the lab, part by part.
# usage: bash commands.sh [work-dir]      (default: ~/os-lab7-rerun)
# The one-line changes are taken from variants/ instead of being made with sed,
# and the broken pipeline is stopped automatically after 1 second.
# ps is limited to the lab's own processes (-p PID --ppid PID).
HERE="$(cd "$(dirname "$0")" && pwd)"
W="${1:-$HOME/os-lab7-rerun}"
mkdir -p "$W" && cd "$W" || exit 1
cp "$HERE"/*.c "$HERE"/variants/*.c .
show() { echo; echo "\$ $*"; eval "$@"; }
part() { echo; echo "================ $* ================"; }

part "Before you start"
show 'gcc --version | head -1'

part "Part 1: fork + exec + wait"
show 'gcc -Wall -Wextra -o run run.c && ./run'
show 'gcc -Wall -Wextra -o run_date run_date.c && ./run_date'
show 'gcc -Wall -Wextra -o run_nosuchprog run_nosuchprog.c && ./run_nosuchprog'

part "Part 2: a zombie (takes about 22 seconds)"
show 'diff run.c zombie.c'
show 'gcc -Wall -Wextra -o zombie zombie.c'
./zombie > /dev/null &
Z=$!
echo; echo '$ ./zombie > /dev/null &'
show 'sleep 2; ps -o pid,ppid,stat,cmd -p $Z --ppid $Z'
show 'sleep 20; ps -o pid,ppid,stat,cmd -p $Z --ppid $Z      # nothing left'

part "Part 3: redirection"
show 'gcc -Wall -Wextra -o redirect redirect.c && ./redirect'
show 'head -3 out.txt'

part "Part 4: a pipe"
show 'gcc -Wall -Wextra -o pipeline pipeline.c && ./pipeline'
show 'ls /etc | wc -l'
show 'diff pipeline.c pipeline_broken.c'
show 'gcc -Wall -Wextra -o pipeline_broken pipeline_broken.c'
set -m                                   # own process group, so the whole job can be killed
./pipeline_broken &
PID=$!
echo; echo '$ ./pipeline_broken &        # never ends'
show 'sleep 1; ps -o pid,ppid,stat,cmd -p $PID --ppid $PID'
kill -- -$PID; wait $PID 2>/dev/null
set +m
echo; echo "(stopped the broken pipeline: kill -- -$PID)"

part "Optional: three stages"
show 'gcc -Wall -Wextra -o pipeline3 pipeline3.c && ./pipeline3'
show 'ls /usr/bin | grep x | wc -l'

echo; echo "All parts done."
