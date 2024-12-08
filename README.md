# About

This repo contains three things.
1. A script to install software i use on any debian-based distro, so that i do not need to remember each step, as some of them require multiple steps to be installed as i need them to be. (version, repository, feature software, ...)
2. My personal collection of dotfiles to configure the just installed software.
3. Systemd configurations and unit files i use on any systemd distro

# How to use

To use the full potential of this script, you need to be on a debian-based distro.

- Clone this repo to your home directory.
`cd $HOME && git clone git@github.com:JonasFocke01/dotfiles.git`

- Make the `debian-installer.sh` executable and, _well_, execute it.
`cd dotfiles && chmod +x debian-installer.sh && ./install-debian.sh`

This will then, step-by-step, install and adjust the distro to my liking. Again, the script asks before each step, so this wont do things you do not want.
