
Fail to mount : RPC Pipe file system
Fail to start : Load Kernel Modules
Fail to start : Cryptography Setup for cryptswap

journalctl -xb # view system logs
systemctl reboot
systemctl default  # boot in default mode


transaction for graphical.target/start is destructive

How to
1. Power on and press F12 to bring up the Lenovo Boot Menu.
2. Move the selection highlight to Pop!_OS 22.04 LTS.
3. Press Enter, then immediately hold down the Spacebar (or continuously tap Spacebar as fast as possible)
4. This stops systemd-boot from loading Linux immediately and displays the actual Pop!_OS boot menu with a countdown.
Once that menu appears, press e, append systemd.unit=multi-user.target nomodeset to the end of the line, and press Enter.


lsblk -f
Look at the nvme0n1 disk structure. You will typically see:
nvme0n1p1: EFI partition (/boot/efi)
nvme0n1p2: Recovery partition (the live system you are currently inside)
nvme0n1p3: Your main Pop!_OS system where your files reside (formatted as ext4 or crypto_LUKS)

sudo mount /dev/nvme0n1p3 /mnt
