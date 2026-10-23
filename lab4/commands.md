# Lab 4 – All commands, in the order they were run

`bash$` = typed in the Linux terminal, `xv6$` = typed at the xv6 prompt after `make qemu`.
Leave xv6 with **Ctrl-A, then X**. The real output of every figure is in `outputs/`, the screenshots in `screenshots/`.

## Before you start
```bash
bash os2026-setup.sh --check        # toolchain, QEMU and ~/xv6-riscv are ready
```

## Part 1 – Fix sleep for the current xv6 (Figures 1.1–1.3)
```bash
bash$ cd ~/xv6-riscv
bash$ grep -n "pause\|sleep" user/user.h      # only "int pause(int);" -> the new name
bash$ cat user/sleep.c                        # already calls pause(atoi(argv[1]))
bash$ grep -n -A5 '^UPROGS' Makefile          # $U/_sleep\ is in UPROGS
bash$ make qemu
xv6$ sleep 20                                 # pauses 20 ticks (~2 s)
xv6$ sleep                                    # usage: sleep <ticks>
```

## Part 2 – bash versus the xv6 shell (Figures 2.1–2.4)
Run in bash, inside an empty test folder with a README (the resulting folder is `generated/shtest/`):
```bash
bash$ mkdir ~/shtest && cd ~/shtest && touch README
bash$ echo hello > f ; cat < f          # redirection
bash$ ls | grep READ                    # pipe
bash$ (echo a; echo b) | wc             # grouping, list
bash$ echo one ; echo two               # sequence
bash$ echo bg &                         # background (job number, PID, "Done")
bash$ ls *                              # globbing -> README f
bash$ echo $HOME                        # variables -> /home/david
bash$ echo "a b"                        # quotes are removed -> a b
bash$ mkdir d ; cd d ; ls ..            # cd works inside a list, ls found via PATH
#      then: arrow up (recall), "ls ../REA" + Tab (-> ../README), Ctrl+R "hello" (search)
```
The same commands at the xv6 prompt:
```
xv6$ echo hello > f ; cat < f           # hello
xv6$ ls | grep READ                     # README  2 2 2441
xv6$ (echo a; echo b) | wc              # 2 2 4
xv6$ echo one ; echo two                # one / two
xv6$ echo bg &                          # bg$  (output races with the prompt)
xv6$ ls *                               # ls: cannot open *        (no globbing)
xv6$ echo $HOME                         # $HOME                    (no variables)
xv6$ echo "a b"                         # "a b"                    (no quotes)
xv6$ mkdir d ; cd d ; ls ..             # exec cd failed + listing of /
xv6$ echo one, then arrow up + Enter, "ec" + Tab + Enter, Ctrl+R "one" + Enter
                                        # no history/completion: exec ... failed
```
ls after `cd d`, and the workarounds (Figure 2.3):
```
xv6$ cd d                               # alone on the line: handled by the shell itself
xv6$ ls                                 # exec ls failed  (no PATH, ls lives in /)
xv6$ ls ..                              # exec ls failed
xv6$ /ls                                # absolute path works
xv6$ /ls .. | /grep README
xv6$ ../echo hello from d               # relative path works
xv6$ cd /
xv6$ ls | grep README                   # short names work again in /
```

## Part 3 – Who expands `*`? (Figures 3.1–3.4)
```bash
bash$ cd ~/xv6-riscv
bash$ cat user/args.c                         # prints argc and every argv[i] in [ ]
bash$ grep -n -A6 '^UPROGS' Makefile          # $U/_args\ added
bash$ make qemu
xv6$ args one              two         three
xv6$ args *.c "x y"                           # argc = 4: [*.c] ["x] [y"]
xv6$ args $HOME                               # [$HOME]
xv6$ args 'single quoted'                     # ['single] [quoted']
```
Linux version, in a folder with some .c files (`~/os-lab4`: args.c, args_linux.c, sleep.c):
```bash
bash$ cd ~/os-lab4
bash$ cat args_linux.c
bash$ gcc -o args args_linux.c && ls
bash$ ./args one              two         three
bash$ ./args *.c "x y"                        # argc = 5: [args.c] [args_linux.c] [sleep.c] [x y]
bash$ ./args $HOME                            # [/home/david]
bash$ ./args 'single quoted'                  # [single quoted]
```

## Part 4 – Read the shell (Figures 4.1–4.4)
```bash
bash$ cd ~/xv6-riscv
bash$ wc -l user/sh.c                         # 499 lines
bash$ grep -n "#define" user/sh.c             # EXEC REDIR PIPE LIST BACK (+ MAXARGS)
bash$ grep -n "case " user/sh.c               # runcmd() cases, gettoken(), parseredirs(), nulterminate()
bash$ grep -n "cd" user/sh.c | head           # line 170: "cannot cd"
bash$ sed -n '163,176p' user/sh.c             # the cd code in main(): chdir in the parent
bash$ grep -n '\$' user/sh.c ; echo "matches for \$: exit $?"         # only the "$ " prompt
bash$ grep -n "'\*'" user/sh.c ; echo "matches for '*': exit $?"      # nothing
bash$ grep -n "whitespace\[\]\|symbols\[\]" user/sh.c                 # the only special characters
```

## Deliverables (copied into this folder)
```bash
mkdir -p ~/os-2026-FloreaDavid/lab4
cp ~/xv6-riscv/user/sleep.c ~/xv6-riscv/user/args.c ~/xv6-riscv/Makefile ~/os-2026-FloreaDavid/lab4/
cp ~/os-lab4/args_linux.c ~/os-2026-FloreaDavid/lab4/
```
