# /bin
IgnorePath '/bin'
IgnorePath '/bin/*'

# /boot
IgnorePath '/boot'
IgnorePath '/boot/*'

# btrfs
IgnorePath '/.btrfsroot'
IgnorePath '/.snapshots'

# /etc
IgnorePath '/etc/*'
IgnorePath '/etc/NetworkManager'
IgnorePath '/etc/dhcpcd.duid'
IgnorePath '/etc/cni'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/ld.so.cache' # "File containing an ordered list of libraries found in the directories specified in /etc/ld.so.conf
IgnorePath '/etc/udev/hwdb.bin' # https://www.freedesktop.org/software/systemd/man/hwdb.html
IgnorePath '/etc/.pwd.lock' # passwd; http://blog.dailystuff.nl/2011/08/the-hunt-for-etc-pwd-lock/
IgnorePath '/etc/.updated' # systemd-update-done.service
IgnorePath '/etc/ca-certificates' # certs
IgnorePath '/etc/ca-certificates/extracted' # certs
IgnorePath '/etc/fstab'
IgnorePath '/etc/group'
IgnorePath '/etc/group-'
IgnorePath '/etc/gshadow'
IgnorePath '/etc/gshadow-'
IgnorePath '/etc/gtk-2.0/gdk-pixbuf.loaders' # GTK
IgnorePath '/etc/lvm/cache/.cache' # LVM cache
IgnorePath '/etc/pacman.d/mirrorlist.pacnew'
IgnorePath '/etc/pacman.d/gnupg' # pacman keyring
IgnorePath '/etc/passwd-'
IgnorePath '/etc/shadow'
IgnorePath '/etc/shadow-'
IgnorePath '/etc/ssh/*_key' # SSH Host private keys
IgnorePath '/etc/ssh/*_key.pub' # SSH Host public keys
IgnorePath '/etc/ssl/certs' # certs Symlinks
IgnorePath '/etc/X11'
IgnorePath '/etc/hostname'
IgnorePath '/etc/hosts'
IgnorePath '/etc/fonts'
IgnorePath '/etc/mkinitcpio.conf'
IgnorePath '/etc/mkinitcpio.d'
IgnorePath '/etc/os-release'
IgnorePath '/etc/passwd'
IgnorePath '/etc/shells'
IgnorePath '/etc/subgid'
IgnorePath '/etc/subuid'
IgnorePath '/etc/vconsole.conf'

# /opt
IgnorePath '/opt'
IgnorePath '/opt/*'

## /usr
IgnorePath '/usr'
IgnorePath '/usr/*'

# /var
IgnorePath '/var'
IgnorePath '/var/*'
IgnorePath '/var/lib'
IgnorePath '/var/lib/*'

# /hal
IgnorePath '/hal'

# /timeshift
IgnorePath '/timeshift'
