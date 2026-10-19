# Lab 7 – Three Small Programs (Linux)

**Florea David, FAF-242** · full report with screenshots: `Lab7_FloreaDavid_FAF-242.docx`

## Part 1 – fork + exec + wait
1. `perror("exec")` runs only if `execlp` **fails**. On success, exec replaces the child's whole program (code, data, stack) with ls/date, so the line no longer exists. With `nosuchprog`, exec fails and returns, so the line runs: `exec: No such file or directory`.
2. The child prints its parent's PID (`getppid()`), e.g. `35083`, which is the PID of the original `./run` process (the same number as in the first line).
3. With ls (and date): **status 0**. With nosuchprog: **status 127**, from the child's own `exit(127)` after the failed exec (`WEXITSTATUS`).

## Part 2 – A zombie
1. ls has **Z** in STAT: a zombie (`[ls] <defunct>`). It has finished, but its process-table entry (PID and exit status) stays until the parent waits for it.
2. After 20 seconds the line is **gone**. The line `waitpid(pid, &status, 0);` reaped it.

## Part 3 – Redirection
1. open gave **1**, because open always returns the lowest free descriptor, and 1 had just been closed (0 was still open).
2. ls always writes to descriptor 1. exec keeps the open descriptors, so in ls, 1 is still out.txt and not the terminal.
3. To redirect the errors, close **2** (stderr) before open.

## Part 4 – A pipe
1. Yes: `./pipeline` and `ls /etc | wc -l` both printed **242**.
2. **wc** never ends (ps shows only `wc -l`, state S; ls had already exited).
3. wc reads until end-of-file, and a pipe gives EOF only when every write end is closed, but the parent still holds `p[1]` open.

Optional: `pipeline3` (`ls /usr/bin | grep x | wc -l`) prints **312**, the same as the shell.
