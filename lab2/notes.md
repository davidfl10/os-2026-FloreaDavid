# Lab 2 – Meet the OS You Will Build (notes)

**Florea David, FAF-242** · Track B (xv6-riscv, commit `06aad25`) · 2026-10-05

## Part 2 – Using xv6

**(1) Three programs xv6 ships with.** `ls`, `cat`, `echo` (also `grep`, `wc`, `sh`, `kill`, `mkdir`, `rm`, `usertests`...). `ls` in the root directory listed 22 programs plus `README` and the `console` device.

**(2) What a pipe needs.** `ls | grep c` printed `cat`, `echo`, `wc`, `sync`, `console`. For this to work the OS must provide:
- **process creation** (`fork` + `exec`): the shell starts `ls` and `grep` as two separate processes running at the same time;
- **inter-process communication** (the `pipe` system call plus file descriptors / `dup`): the kernel buffer connects `ls`'s stdout to `grep`'s stdin.

**(3) xv6 shell vs. Linux shell.** The xv6 `sh` handles the same basics as bash (running programs, `|`, `<`/`>`, `;`, `&`), but it is a ~500-line program with no variables, job control, history, tab completion or scripting.

**Optional `usertests -q`:** `ALL TESTS PASSED`. The `usertrap(): unexpected scause ...` lines it prints come from tests such as `kernmem` and `stacktest` that deliberately make a bad memory access. They check that the kernel kills only the faulting process and keeps running.

## Part 3 – Reading the source

**(1) System calls in `user/cat.c`:**
| call | asks the kernel to... |
|---|---|
| `open(path, O_RDONLY)` | open the named file and return a file descriptor |
| `read(fd, buf, n)` | copy up to `n` bytes from the file into the program's buffer |
| `write(1, buf, n)` | copy `n` bytes from the buffer to fd 1 (stdout, the console) |
| `close(fd)` | release the file descriptor |
| `exit(status)` | terminate the process and return a status to its parent |

(`fprintf` is not a system call. It's a library function in `user/printf.c` that ends up calling `write`.)

**(2) Where `sys_read` lives.** In `kernel/sysfile.c`, **line 69** (`sys_write` is at line 83). It's reached through `kernel/syscall.c`, whose table maps `SYS_read` (number 5, in `kernel/syscall.h`) to `sys_read`.

**(3) `kernel/` vs. `user/`.** `kernel/` is the OS itself and runs in privileged (supervisor) mode with direct access to hardware and all memory. `user/` contains ordinary programs that run unprivileged and can only get things done by asking the kernel through system calls.

## Part 4 – `sleep`

Current xv6 renamed the `sleep` system call to **`pause`** (`int pause(int);` in `user/user.h`, `sys_pause` in `kernel/sysproc.c`, because the kernel already uses `sleep()` internally for its wait-channel primitive). So `user/sleep.c` calls `pause(atoi(argv[1]))` instead of the handout's `sleep()`.

Tested inside xv6:
```
$ sleep
usage: sleep <ticks>
$ echo start; sleep 50; echo done
start            <- 14:39:07.160
done             <- 14:39:12.251   (~5.1 s: one tick is ~100 ms)
```

Optional `pingpong` also works:
```
$ pingpong
10: received ping
9: received pong
```
