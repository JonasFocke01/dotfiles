# My dotfiles and software collection

This repository contains a collection of dotfiles. Feel free to use any individual dotfile, entire sections, or all at once.

## Using all dotfiles

1. Clone repo to $HOME (via ssh if modifications are to be expected)
    To establish a ssh connection to github do
    - `ssh-keygen -f $HOME/.ssh/id_rsa -N '' && cat $HOME/.ssh/*.pub | xclip -selection clipboard && xdg-open https://github.com/settings/ssh/new`
2. Move into dotfiles dir
3. `stow --adopt --no-folding .`
4. `git restore .`
5. `fc-cache -f -v`
6. If you want to use my custom login script for "i3lock": `# cp .config/i3lock/x_i3lock_and_refresh_video_ouputs.sh /etc/zzz.d/resume`

## Software setup

The `README` list all software i install on a [voidlinux-bare](https://voidlinux.org/download/) installation.

Some of the software listed bellow also require the provided installation steps to work propperly. The steps assume, that the installation of that software already happened.

### Essential steps on void-bare

First do a system update with right after installing
1. xbps-install -Suy xbps
2. xbps-install -Suy

Then enable all required remotes
1. void-repo-nonfree # mostly nvidia stuff
2. void-repo-multilib # 32bit libraries
3. void-repo-multilib-nonfree # 32bit, but mostly nvidia stuff

Most essential software:

- feh
- ImageMagick
- xz
- btop
- eza
- fastfetch
- curl
- wget
- git
- qalculate
- cyme (better lsusb)
- zip
- unzip
- 7zip
- ark
- ncdu
- rsync
- ffmpeg
- bat
- jq
- ripgrep
- fzf
- fd

### Desktopenvironment

- i3 -> `# vi /usr/share/xsessions/i3.desktop` => `Exec=i3` -> `Exec=dbus-run-session i3`
- i3blocks
- i3lock
- lightdm
    -> `# ln -s /etc/sv/lightdm /var/service/lightdm`
- lightdm-gtk-greeter
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
- alacritty <span style="color: gray;">[Subject to change]</span>
- xorg
- dbus -> `# ln -s /etc/sv/dbus /var/service/dbus`
- Audiosoftware
    - alsa-utils
    - alsa-plugins
    - alsa-lib
    - alsa-firmware
    - pavucontrol
    - pulseaudio
- sysstat
- [nvidia drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/nvidia.html) (step-by-step because ndidia)
    - nvidia
    - nvidia-libs-32bit
- zsh
    - `chsh -s /usr/bin/zsh`
- Oh-My-Zsh <span style="color: gray;">[Subject to change]</span>
    - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
    - `git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
    - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
- trash-cli <span style="color: gray;">[Subject to change]</span>
- stow
- flatpak -> `# flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
- librewolf <span style="color: gray;">[Flatpak]</span>
- xdg-utils -> `xdg-settings set default-web-browser firefox.desktop`
- qemu-user-static
- snooze
- kde5 <span style="color: gray;">[We probaby only need a polkit frontend, but i could not for the live of me figure this one out. Just install kde5 for now and live with the additiaonal 1GB. This is also needed for dolphin to work properly]</span>
- moreutils
- xclip

### Softwaredevelopment

- bob (nvim) -> `bob install 0.12.5`
- dbeaver
- make
- SDL2-devel
- gcc
- lz4
- gtk+3-devel
- libsoup3-devel
- libwebkit2gtk41-devel
- mariadb -> `# mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql` -> `# ln -s /etc/sv/mysqld /var/service/mysqld`
- cloc
- uv
- mold
- alsa-lib-devel
- openssl-devel
- libudev-devel
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
        5. Add current user to `dialout` **and** `polkitd` groups
        6. `cargo install elf2uf2-rs`


### Officework

- dolphin => make sure, that `/etc/xdg/menus` contains `plasma-applications.menu` and do `# ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu` => UI: configure dolphin -> Context Menu -> Download new -> `Extract Here` by `merrittkr` <span style="color: gray;">[Subject to change]</span>
- flameshot
- vlc
- gimp
- wine
- libreoffice
- uget
- protonvpn
- XClicker
- krita
- darktable
- inkscape
- audacity
- kdenlive
- torbrowser <span style="color: gray;">[Flatpak]</span>

### Media

- steam (takes reeeealy long for first start)
    - Vulkan-Tools
    - gtk2-engines-32bit
    - libgcc-32bit
    - libstdc++-32bit
    - libdrm-32bit
    - libglvnd-32bit
    - mesa-dri-32bit
    - pipewire-32bit
    - libva-32bit
    - libvdpau-32bit
- MangoHud
    - Hint: `nvidia` and `nvidia-libs-32bit` need to be installed for Steam to work
- vesktop (Discord) <span style="color: gray;">[Flatpak]</span>
- playerctl
- Sonora <span style="color: gray;">[Flatpak]</span>
- Feishin <span style="color: gray;">[Same as Sonora, but for smart playlists] [Flatpak] [Subject to change]</span>

### Bluetooth

- libspa-bluetooth
- blueman
- bluez-cups <span style="color: gray;">[Subject to change]</span>
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

### Serverspecific

- docker
- cockpit
- chafa (view img via terminal)

## Additional tips and tricks for my workflow

### Whitelist sudo commands

With this modifications, `sudo xyz` wont prompt for a password (use this carefully)!  
This is needed for e.g. my launcher to work propperly.

- Add `USERNAME ALL=(ALL:ALL)` to the end with visudo
- For each program, that we want to execute without typing in a password, we need another `USERNAME ALL=(ALL:ALL) NOPASSWD: /path/to/executable` at the ***end*** of the file
- For the full experience of the dotfiles, we need
    - `/usr/bin/zzz`
    - `/usr/bin/shutdown`
    - `/usr/bin/efibootmgr`
    - `/usr/bin/mount`
    - `/usr/bin/mkdir`
    - `/usr/bin/tlp` (only on mobile)
 

### Autologin with lightdm

`# vi /etc/lightdm/lightdm.conf` Section `[Seat:*]`
        => `#autologin-user= ` -> `autologin-user=USERNAME`
        => `#autologin-user-timeout=0` -> `autologin-user-timeout=1`

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

### Browserextensions

Browserextensions i use on firefox include, but are not limited to
- ublockorigin
- bitwarden
- No youtube comments
- Tabulator grinder (by jonas)
