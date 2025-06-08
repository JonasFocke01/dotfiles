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
    - For each program, that we want to execute without typing in a password, we need another `USERNAME ALL=(ALL:ALL) NOPASSWD: /path/to/executable` at the END of the file
  	- on void, we need at least `/usr/bin/zzz` and `/usr/bin/shutdown -P now`
- Firefox 133.0.3
- Create ssh key with `ssh-keygen -f $HOME/.ssh/id_rsa -N ''`

- Rust
    Main:
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
	source "$HOME/.cargo/env"
    ```

    To program for rpi picos:
    ```bash
    rustup target add thumbv6m-none-eabi
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/probe-rs/probe-rs/releases/latest/download/probe-rs-tools-installer.sh | sh
    ```
    - follow instructons on (this site)[https://probe.rs/docs/getting-started/probe-setup/]

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
    - xorg`
    - dbus -> `sudo ln -s /var/service/dbus /var/service/`
    - i3 (not i3-wm)
    - i3blocks ? (voidlinux fix: `ln -s /etc/sv/dbus /var/service/`)
    - i3lock 2.13
    - lightdm -> `sudo ln -s /etc/sv/lightdm /var/service/`
    - network-manager-gnome ?
    - dunst 1.12.1
    - flameshot 11.0.0
    - feh 3.6.3
    - imagemagick 6.9.11
    - fzf 0.29
    - fd-find ?
    - ulauncher 5.15.7
    - audio: `alsa-utils alsa-plugins alsa-lib alsa-firmware pavucontrol pulseaudio`
    - udiskie 2.4.2
    - dolphin
    - btop ?
    - wifi TODO
    - bluetooth TODO

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

troubleshooting tips for when using some barebones os like voidlinux, archlinux...:
	- usb mount not working AND/OR probe-rs not connecting correctly: Ensure, that the file `/etc/polkit-1/rules.d/50-udisks.rules` is correct.
 		Current setup: ```javascript
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
	- dbus-session missing:
  edit file `/usr/share/xsessions/i3.desktop`  
 		Replace `Exec=i3` with `Exec=dbus-run-session i3`  
   	- autologin with lightdm:
    		edit `/etc/lightdm/lightdm.conf` and uncomment the lines
      			`autologin-user=` and change it to `autologin-user=USERNAME`
	 		`autologin-user-timeout=0`
