#!/bin/sh

# mount the drive containing your steam library in /etc/fstab
# example:
# UUID=38CE9483CE943AD8 /mnt/data ntfs uid=1000,gid=1000,rw,user,exec,umask=000 0 0

# symlink compat data into the mounted library
rm -rf /mnt/data/SteamLibrary/compatdata
ln -s ~/.steam/steam/steamapps/compatdata /mnt/data/SteamLibrary/compatdata
