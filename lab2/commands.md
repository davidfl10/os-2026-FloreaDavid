# Lab 2 – All commands, in the order they were run

`bash$` = typed in the Linux terminal (in `~/xv6-riscv`), `xv6$` = typed at the xv6 prompt after `make qemu`.
Leave xv6 with **Ctrl-A, then X**. The full transcript of every part is in `outputs/` (one log per part).

Note: in the logs, xv6 was driven by piping the commands into `make qemu` with a timeout, e.g.
`(sleep 4; echo "ls"; sleep 2) | timeout 40 make qemu`. Typing the same commands at the `$` prompt gives
the same result.

## Setup (`outputs/lab2_part0_setup.log`)
```bash
bash$ cd ~/xv6-riscv 2>/dev/null || git clone https://github.com/mit-pdos/xv6-riscv ~/xv6-riscv
bash$ cd ~/xv6-riscv
bash$ git log -1 --format="%h %ad %s" --date=short     # revision 06aad25
bash$ ls -l                                            # kernel/ user/ mkfs/ Makefile README ...
bash$ riscv64-linux-gnu-gcc --version | head -1        # the RISC-V cross-compiler
bash$ which qemu-system-riscv64                        # the emulator
```

## Part 1 – Build it and boot it (`lab2_part1_build.log`, `lab2_part1_boot.log`)
```bash
bash$ make qemu                          # compile the kernel and the user programs, then boot
bash$ make kernel/kernel fs.img          # build only: the kernel and the disk image
bash$ ls -l kernel/kernel fs.img
bash$ qemu-system-riscv64 --version | head -1
# boot test: "xv6 kernel is booting" ... "init: starting sh" ... "$ "
```

## Part 2 – Use xv6 as the Unix it is (`lab2_part2_use.log`, `lab2_part2_usertests.log`)
```
xv6$ ls                     # name, type, inode, size of every file in /
xv6$ cat README
xv6$ echo hello xv6
xv6$ ls | grep c            # pipes work in xv6 too: cat, echo, wc, sync, console
xv6$ wc README
xv6$ usertests -q           # optional: the kernel test suite -> ALL TESTS PASSED
```

## Part 3 – Read the source (`outputs/lab2_part3_source.log`)
```bash
bash$ sed -n "1,40p" user/ls.c                       # a user program
bash$ sed -n "1,30p" user/cat.c
bash$ cat user/user.h                                # the system calls available to programs
bash$ grep -n "sys_read\|sys_write" kernel/sysfile.c | head      # sys_read at line 69, sys_write at 83
bash$ grep -n "read(\|write(\|open(\|close(\|exit(\|fprintf(" user/cat.c   # the system calls cat makes
bash$ grep -n -B1 -A12 "^sys_read" kernel/sysfile.c
bash$ grep -n "sys_read\|sys_write\|sys_pause\|SYS_read\|SYS_write\|SYS_pause" kernel/syscall.c kernel/syscall.h
bash$ grep -n "pause\|read\|write" user/usys.pl       # the user-side stubs (ecall)
bash$ grep -n -A16 "^sys_pause" kernel/sysproc.c      # the kernel side of pause()
bash$ ls kernel/*.[chS] | wc -l; ls user/*.[chS] user/*.pl | wc -l; cat kernel/*.[chS] | wc -l; cat user/*.[chS] | wc -l
                                                      # size of the kernel and of the user programs
```

## Part 4 – The first program: sleep (+ pingpong) (`lab2_part4_sleep_build.log`, `lab2_part4_sleep_test.log`)
```bash
bash$ cat user/sleep.c                               # calls pause(atoi(argv[1])) - sleep() was renamed pause()
bash$ cat user/pingpong.c
bash$ sed -i 's|^\t\$U/_echo\\$|&\n\t$U/_sleep\\\n\t$U/_pingpong\\|' Makefile   # add both to UPROGS
bash$ grep -n "_echo\|_sleep\|_pingpong" Makefile | cat -A      # check: TAB at the start, \ at the end
bash$ make kernel/kernel fs.img
bash$ ls -l user/_sleep user/_pingpong
bash$ make qemu
xv6$ sleep                  # usage: sleep <ticks>
xv6$ sleep abc              # atoi("abc") = 0 -> returns at once
xv6$ echo before
xv6$ sleep 10               # ~1 second (10 ticks): "after" appears 0.9 s later
xv6$ echo after
xv6$ sleep 50               # ~5 seconds
xv6$ pingpong               # 10: received ping / 9: received pong
xv6$ echo start; sleep 50; echo done      # "done" 5.1 s after "start" (timestamps in the log)
```

## Deliverables (copied into this folder)
`sleep.c`, `pingpong.c` and `Makefile` (the original xv6 Makefile with only `$U/_sleep\` and
`$U/_pingpong\` added after `$U/_echo\`, exactly as in Lab 2 - later labs added more programs).
