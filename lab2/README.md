# Lab 2 – Meet the OS You Will Build (xv6)

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

Build xv6 from source, boot it in QEMU, use it, read its source, and write the first programs that run
inside it (sleep, and pingpong). The xv6 programs live in `~/xv6-riscv/user/`; to use them, copy them
there, keep the UPROGS lines of the Makefile, and run `make qemu`.

## What is in this folder

| File | What it is |
|---|---|
| `Lab2_FloreaDavid_FAF-242.pdf` | the report (compiled from `lab2.tex`) |
| `lab2.tex` | the LaTeX source of the report (`pdflatex lab2.tex`; `image.png` is the UTM logo on the title page) |
| `notes.md` | the answers to the Observe questions (notes the report was written from) |
| `sleep.c` | xv6 sleep: `sleep <ticks>`, using the pause() system call |
| `pingpong.c` | one byte parent → child → parent through two pipes |
| `Makefile` | the xv6 Makefile as in Lab 2: `$U/_sleep\` and `$U/_pingpong\` added to UPROGS |
| `commands.md` | every command, in the order it was run, grouped by part |
| `outputs/` | the full transcript of each part: every command followed by its real output |

## Outputs

| Part | Log |
|---|---|
| Setup | `outputs/lab2_part0_setup.log` |
| 1. Build it and boot it | `outputs/lab2_part1_build.log`, `outputs/lab2_part1_boot.log` |
| 2. Use xv6 | `outputs/lab2_part2_use.log`, `outputs/lab2_part2_usertests.log` (ALL TESTS PASSED) |
| 3. Read the source | `outputs/lab2_part3_source.log` |
| 4. sleep (+ pingpong) | `outputs/lab2_part4_sleep_build.log`, `outputs/lab2_part4_sleep_test.log` |
