# Lab 7 – All commands, in the order they were run

Working directory: `~/os-lab7`. The real output of every figure is in `outputs/`, the screenshots in
`screenshots/`. The temporary one-line changes are saved as separate files in `variants/`.
`commands.sh` re-runs everything (it uses the files in `variants/` instead of sed).

## Before you start
```bash
mkdir -p ~/os-lab7 && cd ~/os-lab7
gcc --version | head -1                  # gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0
```

## Part 1 – fork + exec + wait (Figures 1.1–1.4)
```bash
gcc -Wall -Wextra -o run run.c && ./run          # parent, child, ls -l listing, status 0

# 1.3: the child runs date  (= variants/run_date.c)
sed -i 's|execlp("ls", "ls", "-l", (char \*)NULL);|execlp("date", "date", (char *)NULL);|' run.c
grep -n execlp run.c
gcc -Wall -Wextra -o run run.c && ./run          # the date, status 0

# 1.4: a program that does not exist  (= variants/run_nosuchprog.c)
sed -i 's|execlp("date", "date", (char \*)NULL);|execlp("nosuchprog", "nosuchprog", (char *)NULL);|' run.c
grep -n execlp run.c
gcc -Wall -Wextra -o run run.c && ./run          # exec: No such file or directory, status 127

# restore the original (ls -l) - the submitted run.c
sed -i 's|execlp("nosuchprog", "nosuchprog", (char \*)NULL);|execlp("ls", "ls", "-l", (char *)NULL);|' run.c
grep -n execlp run.c
gcc -Wall -Wextra -o run run.c && ./run | tail -2
```

## Part 2 – A zombie (Figures 2.1–2.2)
```bash
diff run.c zombie.c                              # the only change: sleep(20); before waitpid
gcc -Wall -Wextra -o zombie zombie.c
./zombie > /dev/null &                           # in the background, output discarded
sleep 2; ps -o pid,ppid,stat,cmd                 # [ls] <defunct> with STAT Z
sleep 20; ps -o pid,ppid,stat,cmd                # gone: waitpid reaped it
```

## Part 3 – Redirection: ls -l > out.txt (Figure 3.1)
```bash
gcc -Wall -Wextra -o redirect redirect.c && ./redirect   # open gave descriptor 1
head -3 out.txt                                          # the listing is in the file
ls -l out.txt                                            # (the resulting file: generated/out.txt)
```

## Part 4 – A pipe: ls /etc | wc -l (Figures 4.1–4.4)
```bash
gcc -Wall -Wextra -o pipeline pipeline.c && ./pipeline   # 242
ls /etc | wc -l                                          # 242, the same

# 4.3: break it - the parent keeps p[1] open  (= variants/pipeline_broken.c)
sed -i 's|^    close(p\[1\]);$|    /* close(p[1]); */|' pipeline.c
grep -n "p\[1\]" pipeline.c
gcc -Wall -Wextra -o pipeline pipeline.c
./pipeline                                       # hangs -> stop it with Ctrl-C
./pipeline &                                     # again, in the background
sleep 1; ps -o pid,ppid,stat,cmd                 # only "wc -l" is left, sleeping (S)
kill -- -$!                                      # kill the whole job (its process group)
sleep 1; jobs ; ps -o pid,ppid,stat,cmd

# restore it
sed -i 's|^    /\* close(p\[1\]); \*/$|    close(p[1]);|' pipeline.c
grep -n "p\[1\]" pipeline.c
gcc -Wall -Wextra -o pipeline pipeline.c && ./pipeline   # 242 again
```

## Optional – three stages (Figure 4.4)
```bash
gcc -Wall -Wextra -o pipeline3 pipeline3.c && ./pipeline3   # 312
ls /usr/bin | grep x | wc -l                                # 312, the same
```
