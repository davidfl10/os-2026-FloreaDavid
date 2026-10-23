# Lab 3 – The Command Line: Shell, Pipes and Text Filters (Linux)

**Florea David, FAF-242** · Operating Systems, UTM 2026-2027

All commands were run on Ubuntu 26.04 (VirtualBox VM) as the normal user david.

## What is in this folder

| File | What it is |
|---|---|
| `Lab3_FloreaDavid_FAF-242.docx` | the report (UTM format) |
| `oneliners.sh` | the answers to Q1–Q8, one command line each (run: `bash oneliners.sh` in ~/os-lab3) |
| `report.sh` | the Part 5 script, TODO done (per-user failures) |
| `commands.sh` | re-runs all non-interactive commands: `bash commands.sh [folder]` |
| `generated/` | files the lab produced: access.log, out.txt, err.txt, all.txt, notes.md, report.log (cron), play/ |
| `commands.md` | every command, in the order it was run, grouped by part |
| `screenshots/` | every figure of the report, as PNG |
| `outputs/` | the real terminal output of every figure, as text |

## Figures

| Figure | Caption | Screenshot | Output |
|---|---|---|---|
| 1.1 | Tab completion | `screenshots/fig1.1_tab-completion.png` | `outputs/fig1.1_tab-completion.txt` |
| 1.2 | Output of type and which | `screenshots/fig1.2_output-of-type-and-which.png` | `outputs/fig1.2_output-of-type-and-which.txt` |
| 1.3 | The directories in PATH | `screenshots/fig1.3_the-directories-in-path.png` | `outputs/fig1.3_the-directories-in-path.txt` |
| 1.4 | Exit code of a missing command | `screenshots/fig1.4_exit-code-of-a-missing-command.png` | `outputs/fig1.4_exit-code-of-a-missing-command.txt` |
| 1.5 | Reverse history search with Ctrl+R | `screenshots/fig1.5_reverse-history-search-with-ctrl-r.png` | `outputs/fig1.5_reverse-history-search-with-ctrl-r.txt` |
| 1.6 | Searching the manual page of ls (option -t) | `screenshots/fig1.6_searching-the-manual-page-of-ls-option-t.png` | `outputs/fig1.6_searching-the-manual-page-of-ls-option-t.txt` |
| 1.7 | ls --help, man -k and help cd | `screenshots/fig1.7_ls-help-man-k-and-help-cd.png` | `outputs/fig1.7_ls-help-man-k-and-help-cd.txt` |
| 2.1 | Files created in the play directory | `screenshots/fig2.1_files-created-in-the-play-directory.png` | `outputs/fig2.1_files-created-in-the-play-directory.txt` |
| 2.2 | Globbing results | `screenshots/fig2.2_globbing-results.png` | `outputs/fig2.2_globbing-results.txt` |
| 2.3 | The ls error on a name with a space, and the fix | `screenshots/fig2.3_the-ls-error-on-a-name-with-a-space-and-the-fix.png` | `outputs/fig2.3_the-ls-error-on-a-name-with-a-space-and-the-fix.txt` |
| 2.4 | Single quotes, double quotes and backslash | `screenshots/fig2.4_single-quotes-double-quotes-and-backslash.png` | `outputs/fig2.4_single-quotes-double-quotes-and-backslash.txt` |
| 2.5 | Brace expansion, arithmetic expansion and command substitution | `screenshots/fig2.5_brace-expansion-arithmetic-expansion-and-command-substitutio.png` | `outputs/fig2.5_brace-expansion-arithmetic-expansion-and-command-substitutio.txt` |
| 3.1 | stdout and stderr in separate files | `screenshots/fig3.1_stdout-and-stderr-in-separate-files.png` | `outputs/fig3.1_stdout-and-stderr-in-separate-files.txt` |
| 3.2 | Comparing the order of redirections | `screenshots/fig3.2_comparing-the-order-of-redirections.png` | `outputs/fig3.2_comparing-the-order-of-redirections.txt` |
| 3.3 | The ; && \|\| operators | `screenshots/fig3.3_the-operators.png` | `outputs/fig3.3_the-operators.txt` |
| 3.4 | Running a background job and stopping it | `screenshots/fig3.4_running-a-background-job-and-stopping-it.png` | `outputs/fig3.4_running-a-background-job-and-stopping-it.txt` |
| 4.1 | Number of failed requests | `screenshots/fig4.1_number-of-failed-requests.png` | `outputs/fig4.1_number-of-failed-requests.txt` |
| 4.2 | Different pages requested | `screenshots/fig4.2_different-pages-requested.png` | `outputs/fig4.2_different-pages-requested.txt` |
| 4.3 | Number of requests per page | `screenshots/fig4.3_number-of-requests-per-page.png` | `outputs/fig4.3_number-of-requests-per-page.txt` |
| 4.4 | Users with the most failed requests | `screenshots/fig4.4_users-with-the-most-failed-requests.png` | `outputs/fig4.4_users-with-the-most-failed-requests.txt` |
| 4.5 | Requests and failures of user3 | `screenshots/fig4.5_requests-and-failures-of-user3.png` | `outputs/fig4.5_requests-and-failures-of-user3.txt` |
| 4.6 | The last three failed requests | `screenshots/fig4.6_the-last-three-failed-requests.png` | `outputs/fig4.6_the-last-three-failed-requests.txt` |
| 4.7 | Login shells in /etc/passwd | `screenshots/fig4.7_login-shells-in-etc-passwd.png` | `outputs/fig4.7_login-shells-in-etc-passwd.txt` |
| 4.8 | Comparing ls and ls -l line counts | `screenshots/fig4.8_comparing-ls-and-ls-l-line-counts.png` | `outputs/fig4.8_comparing-ls-and-ls-l-line-counts.txt` |
| 4.9 | Full run of oneliners.sh | `screenshots/fig4.9_full-run-of-oneliners-sh.png` | `outputs/fig4.9_full-run-of-oneliners-sh.txt` |
| 4.10 | Bonus – failed requests at minutes ending in 0 | `screenshots/fig4.10_bonus-failed-requests-at-minutes-ending-in-0.png` | `outputs/fig4.10_bonus-failed-requests-at-minutes-ending-in-0.txt` |
| 5.1 | Contents of report.sh | `screenshots/fig5.1_contents-of-report-sh.png` | `outputs/fig5.1_contents-of-report-sh.txt` |
| 5.2 | Running the script on access.log | `screenshots/fig5.2_running-the-script-on-access-log.png` | `outputs/fig5.2_running-the-script-on-access-log.txt` |
| 5.3 | Error handling for a missing file | `screenshots/fig5.3_error-handling-for-a-missing-file.png` | `outputs/fig5.3_error-handling-for-a-missing-file.txt` |
| 5.4 | Running the script without ./ | `screenshots/fig5.4_running-the-script-without.png` | `outputs/fig5.4_running-the-script-without.txt` |
| 5.5 | Installing the crontab line | `screenshots/fig5.5_installing-the-crontab-line.png` | `outputs/fig5.5_installing-the-crontab-line.txt` |
| 5.6 | The report.log written by cron, and removing the crontab | `screenshots/fig5.6_the-report-log-written-by-cron-and-removing-the-crontab.png` | `outputs/fig5.6_the-report-log-written-by-cron-and-removing-the-crontab.txt` |
