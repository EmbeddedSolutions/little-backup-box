#!/usr/bin/env bash

sudo apt update && sudo apt dist-upgrade -y && sudo apt install acl git-core screen rsync exfat-fuse exfat-utils ntfs-3g minidlna gphoto2 libimage-exiftool-perl -y

sudo mkdir /media/card
sudo mkdir /media/storage
sudo chown -R root:root /media/storage
sudo chmod -R 775 /media/storage
sudo setfacl -Rdm g:root:rw /media/storage

cd
git clone https://github.com/EmbeddedSolutions/little-backup-box.git

crontab -l | { cat; echo "@reboot sudo /home/root/little-backup-box/backup.sh > /home/root/little-backup-box.log"; } | crontab
crontab -l | { cat; echo "#@reboot sudo /home/root/little-backup-box/gphoto-backup.sh > /home/root/gphoto-backup.log"; } | crontab

sudo sed -i 's|'media_dir=/var/lib/minidlna'|'media_dir=/media/storage'|' /etc/minidlna.conf
sudo service minidlna start

echo "------------------------"
echo "All done! Please reboot."
echo "------------------------"
