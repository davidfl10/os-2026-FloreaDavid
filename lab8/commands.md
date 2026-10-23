# Lab 8 – All commands, in the order they were run

`bash$` = typed in the Linux terminal (in `~/xv6-riscv`), `xv6$` = typed at the xv6 prompt after `make qemu`.
Leave xv6 with **Ctrl-A, then X**. The real output of every figure is in `outputs/`, the screenshots in
`screenshots/`. The temporary versions of run.c are saved in `variants/`.

## Before you start
New programs: `user/run.c` and (optional) `user/primes.c`; `user/pingpong.c` already existed from Lab 2.
UPROGS lines in the Makefile (TAB at the start, nothing after the backslash):
```makefile
	$U/_pingpong\
	$U/_run\
	$U/_primes\
```

## Part 1 – run, inside xv6 (Figures 1.1–1.7)
```bash
bash$ cd ~/xv6-riscv
bash$ cat user/run.c
bash$ grep -n -A11 "^UPROGS" Makefile
bash$ make qemu
xv6$ run                    # parent: my pid is 3 / child: my pid is 4 / hello from the child / status 0
```
1.3 – the child becomes ls (= `variants/run_ls.c`):
```bash
bash$ sed -i -e 's|{ "echo", "hello", "from", "the", "child", 0 }|{ "ls", 0 }|' \
             -e 's|exec("echo", args);                 // step 2: become echo|exec("ls", args);                   // step 2: become ls|' user/run.c
bash$ grep -n "args" user/run.c
bash$ make qemu             # rebuilds run and the disk image
xv6$ run                    # the listing of /, then status 0
```
1.4 – a program that does not exist (= `variants/run_nosuchprog.c`):
```bash
bash$ sed -i 's|exec("ls", args); |exec("nosuchprog", args); |' user/run.c
bash$ grep -n "exec(" user/run.c
bash$ make qemu
xv6$ run                    # exec failed / parent: child 4 ended with status 1
```
Restore the submitted version (echo):
```bash
bash$ sed -i -e 's|{ "ls", 0 }|{ "echo", "hello", "from", "the", "child", 0 }|' \
             -e 's|exec("nosuchprog", args);                   // step 2: become ls|exec("echo", args);                 // step 2: become echo|' user/run.c
bash$ grep -n "args" user/run.c
```

## Part 2 – pingpong, and the optional primes (Figure 2.1)
```bash
bash$ make qemu
xv6$ pingpong               # 4: received ping / 3: received pong
xv6$ pingpong               # 6: received ping / 5: received pong
xv6$ primes                 # prime 2 3 5 7 11 13 17 19 23 29 31
```

## Deliverables (copied into this folder)
```bash
mkdir -p ~/os-2026-FloreaDavid/lab8
cp ~/xv6-riscv/user/run.c ~/xv6-riscv/user/pingpong.c ~/xv6-riscv/user/primes.c ~/xv6-riscv/Makefile ~/os-2026-FloreaDavid/lab8/
```
