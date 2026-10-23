# Lab 4 – The xv6 Shell from the Outside

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

The xv6 programs live in `~/xv6-riscv/user/`; to use them, copy them there, keep the UPROGS lines of the Makefile, and run `make qemu`.

## What is in this folder

| File | What it is |
|---|---|
| `Lab4_FloreaDavid_FAF-242.docx` | the report (UTM format) |
| `sleep.c` | xv6 sleep using pause() (Part 1) |
| `args.c` | xv6 program that prints its argv (Part 3) |
| `args_linux.c` | the same program for Linux (Part 3) |
| `Makefile` | xv6 Makefile with the UPROGS lines |
| `generated/shtest/` | the bash test folder of Part 2 (README, f, d/) |
| `commands.md` | every command, in the order it was run, grouped by part |
| `screenshots/` | every figure of the report, as PNG |
| `outputs/` | the real terminal output of every figure, as text |

## Figures

| Figure | Caption | Screenshot | Output |
|---|---|---|---|
| 1.1 | The grep result in user.h | `screenshots/fig1.1_the-grep-result-in-user-h.png` | `outputs/fig1.1_the-grep-result-in-user-h.txt` |
| 1.2 | The updated sleep.c and the UPROGS lines | `screenshots/fig1.2_the-updated-sleep-c-and-the-uprogs-lines.png` | `outputs/fig1.2_the-updated-sleep-c-and-the-uprogs-lines.txt` |
| 1.3 | sleep running in xv6, with and without an argument | `screenshots/fig1.3_sleep-running-in-xv6-with-and-without-an-argument.png` | `outputs/fig1.3_sleep-running-in-xv6-with-and-without-an-argument.txt` |
| 2.1 | The commands run in bash | `screenshots/fig2.1_the-commands-run-in-bash.png` | `outputs/fig2.1_the-commands-run-in-bash.txt` |
| 2.2 | The same commands run in xv6 | `screenshots/fig2.2_the-same-commands-run-in-xv6.png` | `outputs/fig2.2_the-same-commands-run-in-xv6.txt` |
| 2.3 | ls failing after cd d, and the working alternative | `screenshots/fig2.3_ls-failing-after-cd-d-and-the-working-alternative.png` | `outputs/fig2.3_ls-failing-after-cd-d-and-the-working-alternative.txt` |
| 2.4 | Arrow up, Tab and Ctrl+R in the xv6 shell | `screenshots/fig2.4_arrow-up-tab-and-ctrl-r-in-the-xv6-shell.png` | `outputs/fig2.4_arrow-up-tab-and-ctrl-r-in-the-xv6-shell.txt` |
| 3.1 | args.c and the UPROGS line | `screenshots/fig3.1_args-c-and-the-uprogs-line.png` | `outputs/fig3.1_args-c-and-the-uprogs-line.txt` |
| 3.2 | args output in xv6 | `screenshots/fig3.2_args-output-in-xv6.png` | `outputs/fig3.2_args-output-in-xv6.txt` |
| 3.3 | args_linux output in bash | `screenshots/fig3.3_args-linux-output-in-bash.png` | `outputs/fig3.3_args-linux-output-in-bash.txt` |
| 3.4 | args_linux.c and its compilation | `screenshots/fig3.4_args-linux-c-and-its-compilation.png` | `outputs/fig3.4_args-linux-c-and-its-compilation.txt` |
| 4.1 | The command kinds defined in sh.c | `screenshots/fig4.1_the-command-kinds-defined-in-sh-c.png` | `outputs/fig4.1_the-command-kinds-defined-in-sh-c.txt` |
| 4.2 | Where each kind is run | `screenshots/fig4.2_where-each-kind-is-run.png` | `outputs/fig4.2_where-each-kind-is-run.txt` |
| 4.3 | The code that handles cd | `screenshots/fig4.3_the-code-that-handles-cd.png` | `outputs/fig4.3_the-code-that-handles-cd.txt` |
| 4.4 | Searching sh.c for code that handles * or $ | `screenshots/fig4.4_searching-sh-c-for-code-that-handles-or.png` | `outputs/fig4.4_searching-sh-c-for-code-that-handles-or.txt` |
