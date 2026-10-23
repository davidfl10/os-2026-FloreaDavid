# Lab 8 – The Same Calls, Inside Your Own OS (xv6)

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

The xv6 programs live in `~/xv6-riscv/user/`; to use them, copy them there, keep the UPROGS lines of the Makefile, and run `make qemu`.

## What is in this folder

| File | What it is |
|---|---|
| `Lab8_FloreaDavid_FAF-242.docx` | the report (UTM format) |
| `run.c` | fork + exec(echo) + wait inside xv6 (Part 1) |
| `pingpong.c` | ping/pong through two pipes (Part 2) |
| `primes.c` | pipe sieve of primes 2..35 (optional) |
| `Makefile` | xv6 Makefile with the UPROGS lines |
| `variants/` | the temporary versions: run_ls.c, run_nosuchprog.c |
| `notes.md` | short answers to the Observe boxes |
| `commands.md` | every command, in the order it was run, grouped by part |
| `screenshots/` | every figure of the report, as PNG |
| `outputs/` | the real terminal output of every figure, as text |

## Figures

| Figure | Caption | Screenshot | Output |
|---|---|---|---|
| 1.1 | user/run.c and the UPROGS lines | `screenshots/fig1.1_user-run-c-and-the-uprogs-lines.png` | `outputs/fig1.1_user-run-c-and-the-uprogs-lines.txt` |
| 1.2 | run in xv6: the child becomes echo | `screenshots/fig1.2_run-in-xv6-the-child-becomes-echo.png` | `outputs/fig1.2_run-in-xv6-the-child-becomes-echo.txt` |
| 1.3 | The child now becomes ls | `screenshots/fig1.3_the-child-now-becomes-ls.png` | `outputs/fig1.3_the-child-now-becomes-ls.txt` |
| 1.4 | run in xv6: the child becomes ls | `screenshots/fig1.4_run-in-xv6-the-child-becomes-ls.png` | `outputs/fig1.4_run-in-xv6-the-child-becomes-ls.txt` |
| 1.5 | exec of a program that does not exist | `screenshots/fig1.5_exec-of-a-program-that-does-not-exist.png` | `outputs/fig1.5_exec-of-a-program-that-does-not-exist.txt` |
| 1.6 | exec failed, and the parent sees status 1 | `screenshots/fig1.6_exec-failed-and-the-parent-sees-status-1.png` | `outputs/fig1.6_exec-failed-and-the-parent-sees-status-1.txt` |
| 1.7 | run.c restored to echo | `screenshots/fig1.7_run-c-restored-to-echo.png` | `outputs/fig1.7_run-c-restored-to-echo.txt` |
| 2.1 | pingpong (run twice) and the optional primes | `screenshots/fig2.1_pingpong-run-twice-and-the-optional-primes.png` | `outputs/fig2.1_pingpong-run-twice-and-the-optional-primes.txt` |
