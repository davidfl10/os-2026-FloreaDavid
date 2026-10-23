# Lab 7 – Three Small Programs: Processes, Redirection, a Pipe (Linux)

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

All commands were run on Ubuntu 26.04 (VirtualBox VM) as the normal user david.

## What is in this folder

| File | What it is |
|---|---|
| `Lab7_FloreaDavid_FAF-242.docx` | the report (UTM format) |
| `run.c` | fork + exec(ls -l) + waitpid (Part 1) |
| `zombie.c` | run.c + sleep(20) before waitpid (Part 2) |
| `redirect.c` | ls -l > out.txt by hand (Part 3) |
| `pipeline.c` | ls /etc \| wc -l by hand (Part 4) |
| `pipeline3.c` | ls /usr/bin \| grep x \| wc -l (optional) |
| `variants/` | the one-line changes: run_date.c, run_nosuchprog.c, pipeline_broken.c |
| `report.md` | short answers to the Observe boxes |
| `commands.sh` | compiles and runs everything: `bash commands.sh [folder]` |
| `generated/out.txt` | the file written by redirect |
| `commands.md` | every command, in the order it was run, grouped by part |
| `screenshots/` | every figure of the report, as PNG |
| `outputs/` | the real terminal output of every figure, as text |

## Figures

| Figure | Caption | Screenshot | Output |
|---|---|---|---|
| 1.1 | run.c: the child becomes ls -l | `screenshots/fig1.1_run-c-the-child-becomes-ls-l.png` | `outputs/fig1.1_run-c-the-child-becomes-ls-l.txt` |
| 1.2 | The child becomes date | `screenshots/fig1.2_the-child-becomes-date.png` | `outputs/fig1.2_the-child-becomes-date.txt` |
| 1.3 | exec of a program that does not exist | `screenshots/fig1.3_exec-of-a-program-that-does-not-exist.png` | `outputs/fig1.3_exec-of-a-program-that-does-not-exist.txt` |
| 1.4 | run.c restored to ls -l | `screenshots/fig1.4_run-c-restored-to-ls-l.png` | `outputs/fig1.4_run-c-restored-to-ls-l.txt` |
| 2.1 | The only difference between run.c and zombie.c | `screenshots/fig2.1_the-only-difference-between-run-c-and-zombie-c.png` | `outputs/fig2.1_the-only-difference-between-run-c-and-zombie-c.txt` |
| 2.2 | The zombie [ls] <defunct>, and the table 20 seconds later | `screenshots/fig2.2_the-zombie-ls-defunct-and-the-table-20-seconds-later.png` | `outputs/fig2.2_the-zombie-ls-defunct-and-the-table-20-seconds-later.txt` |
| 3.1 | redirect: the listing goes into out.txt | `screenshots/fig3.1_redirect-the-listing-goes-into-out-txt.png` | `outputs/fig3.1_redirect-the-listing-goes-into-out-txt.txt` |
| 4.1 | pipeline compared with the real shell | `screenshots/fig4.1_pipeline-compared-with-the-real-shell.png` | `outputs/fig4.1_pipeline-compared-with-the-real-shell.txt` |
| 4.2 | The broken pipeline: wc never ends | `screenshots/fig4.2_the-broken-pipeline-wc-never-ends.png` | `outputs/fig4.2_the-broken-pipeline-wc-never-ends.txt` |
| 4.3 | pipeline.c restored: it ends again and prints 242 | `screenshots/fig4.3_pipeline-c-restored-it-ends-again-and-prints-242.png` | `outputs/fig4.3_pipeline-c-restored-it-ends-again-and-prints-242.txt` |
| 4.4 | pipeline3 prints the same number as the shell | `screenshots/fig4.4_pipeline3-prints-the-same-number-as-the-shell.png` | `outputs/fig4.4_pipeline3-prints-the-same-number-as-the-shell.txt` |
