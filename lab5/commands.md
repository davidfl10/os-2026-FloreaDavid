# Lab 5 – All commands, in the order they were run

Working directory: `~/os-lab5`, as the normal user (not root). The real output of every figure is in
`outputs/`, the screenshots in `screenshots/`, and the files left behind by the experiments in `generated/`.
`commands.sh` re-runs everything (except stretch task d, which needs sudo).

## Before you start
```bash
whoami                                  # must not print root -> david
mkdir -p ~/os-lab5 && cd ~/os-lab5
```

## Part 1 – The tree and the file types (Figures 1.1–1.3)
```bash
ls /                                            # the top of the tree
ls -ld /etc /etc/passwd /bin /dev/null /tmp     # the first letter = the type (d - l c d)
ls -l /dev | head                               # c = character devices, d = directories, l = links
ls -l /dev | grep "^b" | head -4                # b = block devices (loop0...)
file /usr/bin/ls /etc/passwd /bin               # real type from the content; /bin -> usr/bin
du -sh /var/log 2>/dev/null ; du -sh /usr 2>/dev/null    # 43M vs 6.3G
```

## Part 2 – Inodes and links (Figures 2.1–2.5)
```bash
echo hello > notes.txt
stat notes.txt                    # Inode: 527796, Links: 1
ls -li notes.txt                  # inode number in the first column

ln notes.txt hard.txt             # hard link: same inode, links 2
ls -li notes.txt hard.txt
rm notes.txt                      # removes one name only
cat hard.txt ; ls -li hard.txt    # still "hello", links 1

ln -s hard.txt soft.txt           # symbolic link: new inode that stores the path
ls -li hard.txt soft.txt
cat soft.txt
rm hard.txt
cat soft.txt ; ls -l soft.txt     # dangling: No such file or directory; size 8 = "hard.txt"

mkdir d ; ls -ld d                # a new directory has 2 links
mkdir d/x d/y ; ls -ld d          # 4 links: + the ".." of x and y
ls -lai d                         # shows . and .. with their inodes

echo x > one.txt ; ls -l one.txt ; du -h one.txt                # 2 bytes, but 4.0K on disk
truncate -s 1G big.img ; ls -lh big.img ; du -h big.img         # 1.0G, but 0 on disk (sparse)
stat -c "%n: size %s bytes, %b blocks of %B bytes" one.txt big.img
rm big.img
```

## Part 3 – Permissions (Figures 3.1–3.4)
```bash
echo secret > s.txt
chmod 600 s.txt ; ls -l s.txt            # rw-------
chmod 000 s.txt ; cat s.txt              # Permission denied, even for the owner
chmod u+r s.txt ; cat s.txt              # the owner may chmod -> readable again

umask ; touch new.txt ; mkdir newdir ; ls -ld new.txt newdir    # 0002 -> 664 and 775
umask -S                                 # u=rwx,g=rwx,o=rx

mkdir box ; echo hi > box/f
chmod u=r,go= box  ; ls box ; cat box/f     # read only: ls works, cat denied
chmod u=x,go= box  ; ls box ; cat box/f     # execute only: ls denied, cat works
chmod 755 box ; ls -ld box

ls -l /usr/bin/passwd ; ls -ld /tmp      # s = setuid, t = sticky
cat /etc/shadow                          # Permission denied
ls -l /etc/shadow                        # -rw-r----- root shadow
```

## Part 4 – Disks and the kernel as files (Figures 4.1–4.2)
```bash
lsblk                                    # sda: sda1 (1M), sda2 (20G, mounted at /)
df -h                                    # / is 68% full
mount | grep " / "                       # /dev/sda2 on / type ext4
grep -c processor /proc/cpuinfo          # 2 CPUs
head -3 /proc/meminfo                    # MemTotal 3480328 kB
head -5 /proc/self/status                # Name: head  (/proc/self = the reader)
ls -l /proc/self/fd                      # descriptors of ls: 0 1 2 -> terminal, 3 -> the fd directory
```

## Stretch (Figures 5.1–5.3)
```bash
# (a) magic numbers
gzip -c /etc/passwd > notes.txt ; file notes.txt ; xxd notes.txt | head -1   # 1f 8b = gzip
readlink -f /usr/bin/ls ; xxd -l 16 $(readlink -f /usr/bin/ls)              # 7f 45 4c 46 = ELF
file -L /usr/bin/ls | cut -c1-90

# (b) setuid programs
find / -xdev -perm -4000 -type f 2>/dev/null

# (c) a deleted file that is still open
dd if=/dev/zero of=bigfile bs=1M count=100 status=none ; df -m . | tail -1
exec 3< bigfile ; rm bigfile ; ls -l /proc/$$/fd      # 3 -> '.../bigfile (deleted)'
df -m . | tail -1                                     # space NOT freed yet
exec 3<&- ; ls -l /proc/$$/fd ; df -m . | tail -1     # closed -> 100 MB freed

# (d) not done (needs sudo):
# truncate -s 64M disk.img ; mkfs.ext4 disk.img ; sudo mount -o loop disk.img /mnt ; df -h /mnt ; df -i /mnt ; sudo umount /mnt
```
