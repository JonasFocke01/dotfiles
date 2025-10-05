# My dotfiles and software collection

This repository contains a collection of dotfiles.
The `README` also lists common software i use and tips, how to install things how i like them.
Here _might_ be trivial things listed for the sake of having a list of them.

## Dotfiles

For using the full experience of the contained dotfiles, one would do this

- install `stow`
    ```bash
    cd $HOME && \
    git clone git@github.com:JonasFocke01/dotfiles.git && \
    cd dotfiles && \
    stow --adopt . && \
    git restore . && \
    fc-cache -f -v
    ```

- Install scripts (TODO: Is this even correct?)
    - systemd
    ```bash
    sudo cp dotfiles/.config/systemd/user/screenlock_pre@.service /etc/systemd/system/screenlock_pre@.service && \
    sudo cp dotfiles/.config/systemd/user/screenlock_post@.service /etc/systemd/system/screenlock_post@.service && \
    sudo cp dotfiles/.config/systemd/logind.conf /etc/systemd/logind.conf
    sudo systemctl daemon-reload && \
    sudo systemctl enable screenlock_pre@$SUDO_USER.service && \
    sudo systemctl enable screenlock_post@$SUDO_USER.service && \
    ```

## Selfmade stiched-together 'desktop environment'

### Software to be productive on any DE

- Flameshot
- Firefox
- Fzf
- Fd-find
- Btop
- Alacritty
- Eza
- Zsh
    - `chsh -s /usr/bin/zsh`
- Oh-My-Zsh
    - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
    - `git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
    - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
    - `sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50`
- Neovim
- Ripgrep
- Flatpak
    - `sudo flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
- Vlc
- Xclip
- Stow
- [sowon](https://github.com/tsoding/sowon)
    Must be build from source

### i3 Setup to make a barebones distro usable

- i3
- i3blocks
- i3lock
- Lightdm
- Dunst
- Feh
- Imagemagick
- Ulauncher
- Udiskie
- Dolphin

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
- `ln -s /var/service/dbus /var/service/`
- `ln -s /etc/sv/dbus /var/service/`
- `ln -s /etc/sv/lightdm /var/service/`
- Lightdm-gtk-greeter
- Sysstat

### Mobile

- Tlp
- Network-manager-gnome TODO: is this correct?
- Wifi TODO
- Bluetooth TODO

### Additional

This is a handy list of software i use on some machines, but not all.

- Steam
- Vesktop (Discord)
- Spotify
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

## Tips, tricks

### Whitelist sudo commands

This registers some commands, so that `sudo xyz` wont prompt for a password (use this carefully)!

- Add `USERNAME ALL=(ALL:ALL)` to the end with visudo
- For each program, that we want to execute without typing in a password, we need another `USERNAME ALL=(ALL:ALL) NOPASSWD: /path/to/executable` at the END of the file
- For the full experience of this custom DE we need at least `/usr/bin/zzz`, `/usr/bin/shutdown` and `/usr/bin/efibootmgr`

### SSH

- Create ssh key with `ssh-keygen -f $HOME/.ssh/id_rsa -N ''`

### NAS (TODO: Is this even correct?)

To automount a NAS at login, we do
- `echo "//tigerly/Allgemeine\040Daten /mnt/tigerly cifs username=USERNAME,password=PASSWORD,vers=2.0 0 0" | sudo tee -a /etc/fstab`

### Autologin with lightdm:

- Edit `/etc/lightdm/lightdm.conf` and uncomment the lines in section `[Seat:*]`
- Search for `autologin-user=` and change it to `autologin-user=USERNAME`
- Search for `autologin-user-timeout=0` and change it from `0` to `1`

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

### dbus-session missing:

1. Edit file `/usr/share/xsessions/i3.desktop`
2. Replace `Exec=i3` with `Exec=dbus-run-session i3`

TODO: This is probably not what we want to do here, but it works for now
