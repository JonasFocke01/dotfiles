#!/bin/bash

nas_ip="192.168.2.50"
nas_user="manfild"
nas_pass="DSsiKul24Sd"

data_dir="/mnt/tigerly/Allgemeine Daten"
docker_dir="/mnt/tigerly/docker"
video_dir="/mnt/tigerly/video"

sudo mkdir -p "$data_dir"
sudo mkdir -p "$docker_dir"
sudo mkdir -p "$video_dir"

sudo chown $(sudo -u $(whoami) whoami) "/mnt/tigerly" -R

while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done

mountpoint -q "$data_dir" || sudo mount -t cifs "//$nas_ip/Allgemeine Daten" "$data_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$HOME/Desktop" || sudo mount -t cifs "//$nas_ip/Allgemeine Daten/Familie/Jonas/Desktop" "$HOME/Desktop" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$docker_dir" || sudo mount -t cifs "//$nas_ip/docker" "$docker_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
mountpoint -q "$video_dir" || sudo mount -t cifs "//$nas_ip/video" "$video_dir" -o username=$nas_user,password=$nas_pass,uid=$(id -u),gid=$(id -g),vers=2.0
