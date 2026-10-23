# Lab 3 – All commands, in the order they were run

Working directory: `~/os-lab3`. The real output of every command is in `outputs/` (one file per figure),
and the screenshots are in `screenshots/`. `commands.sh` re-runs the non-interactive commands.

## Setup – generate the data set
```bash
mkdir -p ~/os-lab3 && cd ~/os-lab3                      # create and enter the lab folder
for i in $(seq 1 500); do                               # 500 lines: date time userN OK|FAIL /pageN
  echo "2026-10-05 10:$(printf %02d $((i % 60))) user$((i % 7)) $([ $((i % 5)) -eq 0 ] && echo FAIL || echo OK) /page$((i % 4))"
done > access.log
head -3 access.log ; wc -l access.log                   # check: must print "500 access.log"
```

## Part 1 – Move fast, find help (Figures 1.1–1.7)
| Command / key | What it does |
|---|---|
| `ls /usr/sh` + Tab Tab | Tab completes `/usr/sh` → `/usr/share/`; more Tabs list (or offer to list) the candidates |
| `ls /usr/l` + Tab Tab | Ambiguous prefix: the second Tab lists `lib/ lib64/ libexec/ local/` |
| `cd /et` + Tab | Completes to `cd /etc/` |
| `date`, `whoami`, `uname -r` | Three commands to have something in the history |
| Ctrl+R, `dat`, Enter | Reverse history search: finds and re-runs `date` |
| `type cd ; type ls ; type echo ; which ls` | Built-in or external program, and where `ls` is |
| `type -a ls echo` | All the places a name is found (alias, built-in, files) |
| `echo $PATH` | The directories searched for programs |
| `echo $PATH \| tr ':' '\n'` | The same, one directory per line |
| `echo $PATH \| tr ':' '\n' \| wc -l` | How many directories are in PATH (12) |
| `nosuchprog ; echo "exit code: $?"` | Exit code of a command that is not found (127) |
| `man ls`, then `/sort`, `n`, `/Sort by modification`, `q` | Search inside the manual page; option `-t` sorts by time |
| `ls --help \| head` | Short built-in help of ls |
| `man -k "list directory"` | Search the names/descriptions of all manual pages |
| `help cd \| head -12` | Help for a bash built-in |

## Part 2 – What the shell does to your line (Figures 2.1–2.5)
```bash
mkdir -p ~/os-lab3/play && cd ~/os-lab3/play
touch a.c b.c file1.txt file2.txt notes.txt "alfa beta.txt"   # one name contains a space
ls
echo *.c                         # globbing: a.c b.c
echo file?.txt                   # ? = exactly one character
echo [a-b]*                      # first character a or b (also "alfa beta.txt")
echo *.xyz                       # no match -> the pattern stays literal
ls alfa beta.txt                 # word splitting -> two arguments, both fail
ls "alfa beta.txt"               # fix 1: quotes
ls alfa\ beta.txt                # fix 2: backslash
ls -l
echo '$HOME' "$HOME" \$HOME      # single quotes / double quotes / backslash
echo {1..5} ; echo $((7 * 6))    # brace expansion, arithmetic expansion
echo "today is $(date +%A), I am $(whoami)"    # command substitution
touch log{1..3}.txt && ls log*
```

## Part 3 – Redirection, chaining and jobs (Figures 3.1–3.4)
```bash
cd ~/os-lab3
ls /etc /nope > out.txt 2> err.txt          # stdout -> out.txt, stderr -> err.txt
wc -l out.txt ; cat err.txt
ls /etc /nope > all.txt 2>&1 ; tail -2 all.txt   # both streams into all.txt
head -2 all.txt ; wc -l all.txt
ls /etc /nope 2>&1 > all.txt                # order matters: the error stays on the terminal
head -2 all.txt ; wc -l all.txt
echo first > notes.md ; echo second >> notes.md ; cat notes.md   # > truncates, >> appends
wc -l < access.log                          # stdin redirect: only the number
wc -l access.log                            # file argument: number + name
ls /nope 2> /dev/null || echo "failed with code $?"   # || runs on failure
mkdir -p tmp && cd tmp && echo "I am in $(pwd)" ; cd ~/os-lab3   # && chain, ; always runs
false ; echo "; runs anyway"
false && echo "&& - not printed"
true || echo "|| - not printed"
sleep 100 &                                 # background job
jobs ; kill %1 ; jobs                       # list, kill job 1, list again
jobs                                        # now shows "Terminated"
```

## Part 4 – One-liners (Figures 4.1–4.10)
All eight answers are in `oneliners.sh` (run it with `bash oneliners.sh` inside `~/os-lab3`).
```bash
grep -c FAIL access.log                                            # Q1: 100
cut -d' ' -f5 access.log | sort -u | nl                            # Q2: 4 pages
cut -d' ' -f5 access.log | sort | uniq -c                          # Q3: 125 each
grep FAIL access.log | cut -d' ' -f3 | sort | uniq -c | sort -rn | awk 'NR==1{max=$1} $1==max'   # Q4: user3, user5 (15)
echo "user3: $(grep -cw user3 access.log) requests, $(grep -w user3 access.log | grep -c FAIL) failed"   # Q5
grep FAIL access.log | tail -3 | cut -d' ' -f2,3                   # Q6
cut -d: -f7 /etc/passwd | sort | uniq -c | sort -rn                # Q7
ls /etc | wc -l ; ls -l /etc | wc -l ; ls -l /etc | head -3        # Q8: differ by the "total" line
bash oneliners.sh                                                  # full run
grep -E '^[^ ]+ 10:[0-5]0 [^ ]+ FAIL' access.log | head -12        # bonus: lines
grep -cE '^[^ ]+ 10:[0-5]0 [^ ]+ FAIL' access.log                  # bonus: 50
```

## Part 5 – The script (Figures 5.1–5.6)
```bash
cat report.sh
chmod -x report.sh ; ./report.sh access.log      # Permission denied without the x bit
chmod +x report.sh ; ls -l report.sh
./report.sh access.log                           # 500 requests, 100 failed + per-user lines
./report.sh nope.log ; echo "exit code: $?"      # error on stderr, exit code 1
./report.sh nope.log 2> /dev/null ; echo "exit code: $?"
report.sh access.log                             # command not found: . is not in PATH
type report.sh ; echo $PATH | tr ":" "\n" | grep -c os-lab3
```

### Bonus – cron
```bash
echo '* * * * * /home/david/os-lab3/report.sh /home/david/os-lab3/access.log >> /home/david/os-lab3/report.log 2>&1' | crontab -
crontab -l                       # check the installed line
date ; grep -c requests report.log   # ~3.5 minutes later: 4 reports
tail -16 report.log
crontab -r ; crontab -l          # remove the crontab: "no crontab for david"
```
The resulting log is `generated/report.log`.
