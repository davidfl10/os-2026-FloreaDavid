# Lab 8 – The Same Calls Inside Your Own OS (xv6) – notes

**Florea David, FAF-242** · full report with screenshots: `Lab8_FloreaDavid_FAF-242.docx`

## Part 1 – run inside xv6
1. xv6: `fork()`, `exec("echo", args)`, `wait(&status)`. Linux (Lab 7): `fork()`, `execlp("ls", "ls", "-l", NULL)`, `waitpid(pid, &status, 0)`.
   The same three steps with the same meaning: copy the process, replace its program (exec returns only on failure), wait for the child and get its exit status. Linux only adds glibc conveniences (PATH search, argument list, `waitpid` for a specific child, encoded status).
2. **echo** prints "hello from the child". The child replaced itself with echo via exec and echo prints its argv; run.c has no such printf.
3. The status is the number the child passes to `exit` after a failed exec: `exit(1)` in the xv6 run.c, `exit(127)` in the Linux run.c.

## Part 2 – pingpong
Output: `4: received ping` then `3: received pong` (ping always first, from the child).
1. A pipe is one-way and does not know who wrote a byte. With a single pipe, the parent could read back its own ping. Two pipes give each direction its own channel.
2. `read(c2p[0], &b, 1)`: read on an empty pipe blocks until the child writes the pong.

Optional: `primes` prints prime 2 3 5 7 11 13 17 19 23 29 31, using a chain of 11 processes connected by pipes.
