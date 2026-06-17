# My dotfiles and software collection

This repository contains a collection of dotfiles.
The `README` also lists common software i use and tips, how to install things to my liking.
The list of software and the install instructions are in part very specific to my setup on [void-bare](https://voidlinux.org/download/).

[v] => Confirmed to be only working/available/required in the `xbps` ecosystem, or only tested there.\
[p] => Needs further investigation. Might be modified or ignored in the future, but this is fine for now.\
[f] => Currently requires being installed via flatpak. (Might only be because im to lazy or incompetent)\
All sub-points inherit the markings of theyr parents.

## List of software

### Essentials on any desktop

- feh
- imageMagick
- xz
- btop
- eza
- fastfetch
- aspell + aspell-de + aspell-en
- curl
- wget
- git
- qalculate
- timer
- cyme
- zip
- unzip
- 7zip
- ark
- ncdu
- rsync
- unrar
- ffmpeg
- bat
- jq
- ripgrep
- fzf
- fd

# Serverspecific

- docker
- cockpit

### Desktopenvironment

- i3 -> `# vi /usr/share/xsessions/i3.desktop` => `Exec=i3` -> `Exec=dbus-run-session i3`
- i3blocks
- i3lock
- lightdm
    -> `# ln -s /etc/sv/lightdm /var/service/lightdm`
    Autologin:
    -> `# vi /etc/lightdm/lightdm.conf` Section `[Seat:*]`
        => `#autologin-user= ` -> `autologin-user=USERNAME`
        => `#autologin-user-timeout=0` -> `autologin-user-timeout=1`
- [v] lightdm-gtk-greeter
- dunst
- picom
- ulauncher
- udiskie
- wmctrl
- pkg-config
- gvfs
- fbv
- NetworkManager -> `# ln -s /etc/sv/NetworkManager /var/service/NetworkManager` -> `# rm /var/service/dhcpcd`
- network-manager-applet
- chrony -> `# ln -s /etc/sv/chronyd /var/service/chronyd` # Why is this here
- [p] alacritty
- [v] xorg
- [v] dbus -> `# ln -s /etc/sv/dbus /var/service/dbus`
- [v] Audiosoftware
    - alsa-utils
    - alsa-plugins
    - alsa-lib
    - alsa-firmware
    - pavucontrol
    - pulseaudio
- [v] sysstat
- [v] [nvidia drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/nvidia.html)
- zsh
    - `chsh -s /usr/bin/zsh`
- [p] Oh-My-Zsh
    - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
    - `git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
    - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
- [p] trash-cli
- stow
- [p] flatpak -> `# flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
- firefox -> set `pdfjs.enableHWA` in `about:config` to `false`
- xdg-utils -> `xdg-settings set default-web-browser firefox.desktop`
- qemu-user-static
- snooze
- [p] kde5 *We probaby only need a polkit frontend, but i could not for the live of me figure this one out. Just install kde5 for now and live with the additiaonal 1GB. This is also needed for dolphin to work properly*
- moreutils
- xclip

### Softwaredevelopment

- neovim
- dbeaver
- make
- [v] SDL2-devel
- gcc
- lz4
- gtk+3-devel
- libsoup3-devel-3.4.2_1
- libwebkit2gtk41-devel-2.50.4_1
- [github_issue_roulette](https://github.com/JonasFocke01/github_issue_roulette)
- mariadb -> `# mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql` -> `# ln -s /etc/sv/mysqld /var/service/mysqld`
- cloc
- Rust
    - x86_64-unknown-linux-gnu
        ```bash
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
        source "$HOME/.cargo/env"
        ```
    - thumbv6m-none-eabi (rpi pico):
        1. `rustup target add thumbv6m-none-eabi`
        2. `curl --proto '=https' --tlsv1.2 -LsSf https://github.com/probe-rs/probe-rs/releases/latest/download/probe-rs-tools-installer.sh | sh`
        3. `xdg-open https://probe.rs/docs/getting-started/probe-setup/`
        4. Edit `/etc/polkit-1/rules.d/50-udisks.rules` to be
                ```javascript
                polkit.addRule(function(action, subject) {
                var YES = polkit.Result.YES;
                // NOTE: there must be a comma at the end of each line except for the last:
                var permission = {
                        // required for udisks1:
                        "org.freedesktop.udisks.filesystem-mount": YES,
                        "org.freedesktop.udisks.luks-unlock": YES,
                        "org.freedesktop.udisks.drive-eject": YES,
                        "org.freedesktop.udisks.drive-detach": YES,
                        // required for udisks2:
                        "org.freedesktop.udisks2.filesystem-mount": YES,
                        "org.freedesktop.udisks2.encrypted-unlock": YES,
                        "org.freedesktop.udisks2.eject-media": YES,
                        "org.freedesktop.udisks2.power-off-drive": YES,
                        // Dolphin specific
                        "org.freedesktop.udisks2.filesystem-mount-system": YES,
                        // required for udisks2 if using udiskie from another seat (e.g. systemd):
                        "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
                        "org.freedesktop.udisks2.filesystem-unmount-others": YES,
                        "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
                        "org.freedesktop.udisks2.eject-media-other-seat": YES,
                        "org.freedesktop.udisks2.power-off-drive-other-seat": YES
                };
                if (subject.isInGroup("wheel")) {
                        return permission[action.id];
                }
                });
                ```
           Troubleshooting advice: pico probe requires us to put a file in **directory** rules.d, not ~file~ rules.d
      5. Add current user to `dialout` group


### Officework

- [p] dolphin => make sure, that `/etc/xdg/menus` contains `plasma-applications.menu` and do `# ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu` => UI: configure dolphin -> Context Menu -> Download new -> `Extract Here` by `merrittkr`
- flameshot
- vlc
- gimp
- wine
- wine-32bit
- libreoffice
- uget
- protonvpn
- XClicker
- Krita
- darktable
- inkscape
- audacity
- kdenlive

### Media

- SubTUI
- [remindy](https://github.com/JonasFocke01/remindy)
- [f] spotify
- [p] Steam (takes reeeealy long for first start)
    - [v] Vulkan-Tools
    - [p][v] gtk2-engines-32bit
    - [v] libgcc-32bit
    - [v] libstdc++-32bit
    - [v] libdrm-32bit
    - [v] libglvnd-32bit
    - [v] mesa-dri-32bit
    - [v] pipewire-32bit
    - [v] libva-32bit
    - [v] libvdpau-32bit
- MangoHud
    - Hint: `nvidia` and `nvidia-libs-32bit` need to be installed for Steam to work
- [f] vesktop (Discord)
- playerctl

### Bluetooth

- libspa-bluetooth
- blueman
- [p] bluez-cups
- bluez

### Printer

- cups
- cups-filters
- gutenprint
- system-config-printer
- hplip (for HP printers) -> `sudo ln -s /etc/sv/cupsd /var/service/`
- run `hp-setup` and walk through the installer

### Battery

- tlp

## Dotfiles

### Adopt dotfiles

1. Clone repo to $HOME (via ssh if modifications are to be expected)
    To establish a ssh connection to github do
    - `ssh-keygen -f $HOME/.ssh/id_rsa -N '' && cat $HOME/.ssh/*.pub | xclip -selection clipboard && xdg-open https://github.com/settings/ssh/new`
2. Move into dotfiles dir
3. `stow --adopt --no-folding .`
4. `git restore .`
5. `fc-cache -f -v`
6. `# cp .config/i3lock/x_i3lock_and_refresh_video_ouputs.sh /etc/zzz.d/resume`

### Whitelist sudo commands

With this modifications, `sudo xyz` wont prompt for a password (use this carefully)!

- Add `USERNAME ALL=(ALL:ALL)` to the end with visudo
- For each program, that we want to execute without typing in a password, we need another `USERNAME ALL=(ALL:ALL) NOPASSWD: /path/to/executable` at the ***end*** of the file
- For the full experience of the dotfiles, we need
    - `/usr/bin/zzz`
    - `/usr/bin/shutdown`
    - `/usr/bin/efibootmgr`
    - `/usr/bin/mount`
    - `/usr/bin/mkdir`
    - `/usr/bin/tlp` (only on mobile)

### Install splashscreen

1. `# cp voidsplash /bin`
2. `# vi /etc/runit/1` -> Insert line `/bin/voidsplash` as early as possible (just below `#!`)
3. `# mkdir /etc/voidsplash`
4. `# cp splashscreen.png /etc/voidsplash`
5. `# vi /etc/default/grub`
    => `GRUB_CMDLINE_LINUX_DEFAULT="[...]"` -> `GRUB_CMDLINE_LINUX_DEFAULT="[...] console=tty2"`
6. `# grub-mkconfig -o /boot/grub/grub.cfg`

Reference: [voidsplash](https://github.com/jaylesworth/voidsplash)

### Skip grub menu

`# vi /etc/default/grub`
=> `#GRUB_TIMEOUT=5` -> `GRUB_TIMEOUT=0`
=> `# update-grub`

### Firefox not rendering pdf

Make sure, `pdfjs.enableHWA` in `about:config` is set to `false`
