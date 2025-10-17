# My dotfiles and software collection

This repository contains a collection of dotfiles.
The `README` also lists common software i use and tips, how to install things how i like them.
Here _might_ be trivial things listed for the sake of having a list of them.

## Selfmade stiched-together 'desktop environment'

Hint for voidlinux: run `sudo xbps-install -Su`

### Software to be productive on any DE

- Flameshot
- Firefox
- Fzf
- Fd
- Btop
- Alacritty
- Eza
- Zsh
    - `chsh -s /usr/bin/zsh`
- Oh-My-Zsh
    - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
    - `git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
    - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
- Neovim
- Ripgrep
- Flatpak
    - `sudo flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
- Vlc
- Xclip
- Stow
- bat
- ncspot
- audacity
- gimp
- ffmpeg
- kdenlive
- dbeaver
- trash-cli
- curl
- wget
- fastfetch
- git
- jq
- zip
- libreoffice
- [cyme](https://github.com/tuna-f1sh/cyme/releases)
- [sowon](https://github.com/tsoding/sowon)
- [github_issue_roulette](https://github.com/JonasFocke01/github_issue_roulette)
- [remindy](https://github.com/JonasFocke01/remindy)

### i3 Setup to make a barebones distro usable

- i3
- i3blocks
- i3lock
- Lightdm
- Dunst
- Picom
- Feh
- ImageMagick
- Ulauncher
- Udiskie
- wmctrl
- make
- SDL2-devel
- gcc
- pkg-config
- Thunar
- gvfs

### Voidlinux specific

- Xorg
- Xz (package with `tar` and so on)
- Dbus
- Audio
    - alsa-utils
    - alsa-plugins
    - alsa-lib
    - alsa-firmware
    - pavucontrol
    - pulseaudio
- `ln -s /etc/sv/dbus /var/service/dbus`
- `ln -s /etc/sv/lightdm /var/service/lightdm`
- Lightdm-gtk-greeter
- Sysstat
- Vulkan-Tools
- [nvidia drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/nvidia.html)

### Mobile

- Tlp
- NetworkManager -> `sudo ln -s /etc/sv/NetworkManager /var/service/`
- Bluetooth
    - libspa-bluetooth
    - blueman
    - bluez-cups

### Additional

This is a handy list of software i use on some machines, but not all.

- Steam (takes reeeealy long to start; xbps version needs further investigation. Is this all correct?)
    - gtk2-engines-32bit
    - libgcc-32bit
    - libstdc++-32bit
    - libdrm-32bit
    - libglvnd-32bit
    - mesa-dri-32bit
    - pipewire-32bit
    - libva-32bit
    - libvdpau-32bit
    - I also installed this `octoxbps cinnamon-all xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils` but i dont know if this helps. Anyway, i rebooted and logged into cinnamon before it worked
- Vesktop (Discord)
- Spotify
- Filelight
- ytDownloader (after install: `sudo flatpak override io.github.aandrew_me.ytdn --filesystem=home`)
- JDownloader  (after install: `sudo flatpak override org.jdownloader.JDownloader --filesystem=home`)
- Mariadb
  On voidlinux do
    1. xbps install
    2. `sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql`
    3. Enable service: `sudo ln -s /etc/sv/mysqld /var/service/mysqld`
- Rust
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    source "$HOME/.cargo/env"
    ```

    To program for rpi picos:
    ```bash
    rustup target add thumbv6m-none-eabi
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/probe-rs/probe-rs/releases/latest/download/probe-rs-tools-installer.sh | sh
    ```
    follow instructons on [this site](https://probe.rs/docs/getting-started/probe-setup/)

## Dotfiles

HINT: Install SSH to connect with GH first before cloning anything

For using the full experience of the contained dotfiles, one would do this:

```bash
cd $HOME && \
git clone git@github.com:JonasFocke01/dotfiles.git && \
cd dotfiles && \
stow --adopt . && \
git restore . && \
fc-cache -f -v && \
sudo cp .config/i3lock/x_i3lock_and_refresh_video_ouputs.sh /etc/zzz.d/resume
```

## Tips, tricks

### Whitelist sudo commands

This registers some commands, so that `sudo xyz` wont prompt for a password (use this carefully)!

- Add `USERNAME ALL=(ALL:ALL)` to the end with visudo
- For each program, that we want to execute without typing in a password, we need another `USERNAME ALL=(ALL:ALL) NOPASSWD: /path/to/executable` at the END of the file
- For the full experience of the dotfiles, we need at least
    - `/usr/bin/zzz`
    - `/usr/bin/shutdown`
    - `/usr/bin/efibootmgr`
    - `/usr/bin/mount`
    - `/usr/bin/mkdir`

### SSH

- Create ssh key with `ssh-keygen -f $HOME/.ssh/id_rsa -N ''`

### Autologin with lightdm:

- Edit `/etc/lightdm/lightdm.conf` and uncomment the lines in section `[Seat:*]`
- Search for `autologin-user=` and change it to `autologin-user=USERNAME`
- Search for `autologin-user-timeout=0` and change it from `0` to `1`

### Printer

TODO: Investigate if this works

`sudo xbps-install -y cups cups-filters gutenprint system-config-printer`
`sudo ln -s /etc/sv/cupsd /var/service/`
`sudo xbps-install -y gnome-system-tools users-admin`

### Default applications

#### Voidlinux
1. Install xdg-settings
2. `xdg-settings set default-web-browser firefox.desktop`

## Troubleshooting advice

### Usb mount not working AND/OR probe-rs not connecting correctly

Ensure, that the file `/etc/polkit-1/rules.d/50-udisks.rules` is correct.

Current setup:
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

### Install splashscreen

Reference: [voidsplash](https://github.com/jaylesworth/voidsplash)

1. Copy `voidsplash` to `/bin`
2. Edit `/etc/runit/1` -> Insert line `/bin/voidsplash` as early as possible
3. Create directory `/etc/voidsplash`
4. Move `splashscreen.png` to `/etc/voidsplash`
5. Edit `/etc/default/grub` -> Edit line `GRUB_CMDLINE_LINUX_DEFAULT` to contain `[...] console=tty2'`
6. Run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

### dbus-session missing:

1. Edit file `/usr/share/xsessions/i3.desktop`
2. Replace `Exec=i3` with `Exec=dbus-run-session i3`

TODO: This is probably not what we want to do here, but it works for now

### disable grub menu

Set the timeout in `/etc/default/grub` to 0. Then do `sudo update-grub`.
