#!/bin/bash

nas_ip="192.168.2.50"
nas_user="manfild"
nas_pass="DSsiKul24Sd"

focke_els_dir="/mnt/tigerly/Allgemeine Daten/Focke Event Lighting Systems"
tausch_dir="/mnt/tigerly/Allgemeine Daten/Sonstiges/Tausch"
home_dir="/mnt/tigerly/Allgemeine Daten/Familie/Jonas"
docker_dir="/mnt/tigerly/Docker"
media_dir="/mnt/tigerly/Media"
seedbox_dir="/mnt/Seedbox"
server_pi_dir="/mnt/Server PI"
jonas_handy_sync="/mnt/Handy"
backup_dir="/mnt/backup"

sudo mkdir -p "$tausch_dir"
sudo mkdir -p "$focke_els_dir"
sudo mkdir -p "$home_dir"
sudo mkdir -p "$docker_dir"
sudo mkdir -p "$media_dir"
sudo mkdir -p "$exchange_dir"
sudo mkdir -p "$seedbox_dir"
sudo mkdir -p "$server_pi_dir"
sudo mkdir -p "$jonas_handy_sync"
sudo mkdir -p "$backup_dir"

sudo chown $(sudo -u $(whoami) whoami) "/mnt/tigerly" -R
sudo chown $(sudo -u $(whoami) whoami) "/mnt/seedbox" -R
sudo chown $(sudo -u $(whoami) whoami) "/mnt/server_pi_dir" -R
sudo chown $(sudo -u $(whoami) whoami) "/mnt/backup_dir" -R

while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done

mountpoint -q "$focke_els_dir" || sudo mount -t cifs "//$nas_ip/Allgemeine Daten/Focke Event Lighting Systems" "$focke_els_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$tausch_dir" || sudo mount -t cifs "//$nas_ip/Allgemeine Daten/Sonstiges/Tausch" "$tausch_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$home_dir" || sudo mount -t cifs "//$nas_ip/Allgemeine Daten/Familie/Jonas" "$home_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$docker_dir" || sudo mount -t cifs "//$nas_ip/docker" "$docker_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$media_dir" || sudo mount -t cifs "//$nas_ip/video" "$media_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$exchange_dir" || sudo mount -t cifs "//$nas_ip/Allgemeine Daten/Sonstiges/Tausch" "$exchange_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$seedbox_dir" || sudo mount -t cifs "//192.168.2.99/Public" "$seedbox_dir" -o username="jonas",password="Lockwood",uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$server_pi_dir" || sudo mount -t cifs "//192.168.2.16/Shared" "$server_pi_dir" -o username="pi",password="Lockwood",uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$jonas_handy_sync" || sudo mount -t cifs "//$nas_ip/docker/syncthing/Jonas-Handy-sync/" "$jonas_handy_sync" -o username="$nas_user",password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$backup_dir" || sudo mount -t cifs "//192.168.2.95/Public" "$backup_dir" -o username="jonas",password="sdf",uid=$(id -u),gid=$(id -g),vers=2.0
