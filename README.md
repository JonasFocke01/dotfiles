# About

This project contains
- all my dotfiles
- the corresponding software
- instructions to build that software

# Instructions

This is intended to serve as a step by step guide to setup the software, that will be configured via the mentioned dotfiles.
Version numbers are a snapshot of my current setup.

- Do not forget to `update && upgrade` a new system
- Add user to sudoers file and disable password promt from efibootmgr
    - Add `USERNAME ALL=(ALL:ALL)` to the end with visudo
    - Add ` NOPASSWD: /usr/bin/efibootmgr" >> /etc/sudoers` to that line to disable the password prompt for that user for the efibootmgr. (Required for some ulauncher options)
- Firefox 133.0.3
- Create ssh key
    1. `ssh-keygen -f $HOME/.ssh/id_rsa -N ''`
    2. copy the output of `cat .ssh/id_rsa.pub to`
        1. Gitub `https://github.com/settings/keys`
        2. Linux servers `$HOME/.ssh/authorized_keys`
- Rust
    Main:
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
	source "$HOME/.cargo/env"
    ```

    To program for rpi picos:
    ```bash
    cargo install elf2uf2-rs && \
    cargo install rustup target add thumbv6m-none-eabi && \
    cargo install probe-rs && \
    ```
    - libudev-dev

- Shell
    - Alacritty 0.15.0
    - zsh
        - zsh 5.8.1
        - fzf 0.29
        - `cargo install exa`
        - `chsh -s /usr/bin/zsh`
        - Oh-My-Zsh
            - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
            - `git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions`
            - `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`
            - `sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50`
        - purge bash
            ```bash
            sudo rm -r \
                    .bash_history \
                    .bash_logout \
                    .bashrc
            ```
- Tlp 1.5.0 (Battery management)
- Remove nano
- Neovim 0.10.3
    - Ripgrep 13.0.0
- clone wip repos
- Install gaming suite
    - Steam
    - Discord
    - Spotify
- Automount NAS
    - `echo "//tigerly/Allgemeine\040Daten /mnt/tigerly cifs username=USERNAME,password=PASSWORD,vers=2.0 0 0" | sudo tee -a /etc/fstab`
- fnm (fast node manager) 1.38.1
- vlc 3.0.16
- Desktop Environment
    - xorg: `xorg-server xorg-apps xorg-minimal xinit xterm xcape`
    - i3-wm ?
    - i3blocks ? (voidlinux fix: `ln -s /etc/sv/dbus /var/service/`)
    - i3lock 2.13
    - network-manager-gnome ?
    - dunst 1.12.1
    - flameshot 11.0.0
    - feh 3.6.3
    - imagemagick 6.9.11
    - fzf 0.29
    - fd-find ?
    - ulauncher 5.15.7
    - audio: `alsa-utils alsa-plugins alsa-lib alsa-firmware pavucontrol`
    - copyq 6.0.1
    - udiskie 2.4.2
    - btop ?
    - wifi TODO
    - bluetooth TODO
    - Create a nasa api key on `https://api.nasa.gov/` and save it to `dotiles/.config/i3/nasa-api-key`
- Use dotfiles
    - stow 2.3.1
    ```bash
    git clone git@github.com:JonasFocke01/dotfiles.git && \
    cd dotfiles && \
    stow --adopt . && \
    git restore . && \
    fc-cache -f -v
    ```
    - Install scripts into display manager (systemd in this example) (script from `.config/systemd/*`)
        - systemd
        ```bash
        sudo cp dotfiles/.config/systemd/user/screenlock_pre@.service /etc/systemd/system/screenlock_pre@.service && \
        sudo cp dotfiles/.config/systemd/user/screenlock_post@.service /etc/systemd/system/screenlock_post@.service && \
        sudo cp dotfiles/.config/systemd/logind.conf /etc/systemd/logind.conf
        sudo systemctl daemon-reload && \
        sudo systemctl enable screenlock_pre@$SUDO_USER.service && \
        sudo systemctl enable screenlock_post@$SUDO_USER.service && \
        ```
