#!/bin/bash

echo "Debian (apt) installer"
echo

echo "Update System now (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt update -y
	sudo apt upgrade -y
fi

echo "Install Firefox? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install firefox -y
fi

echo "create new ssh key? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    cd $HOME
	ssh-keygen -f $HOME/.ssh/id_rsa -N ''
	sudo apt install xclip -y
	echo "Go to the Github login page and log in. The URL is in your clipboard"
	echo "https://github.com/login" | xclip -sel clip
	echo "proceed with any key"
	read confirmation;
	echo "Now go to the settings and ssh keys. The URL is in your clipboard"
	echo "https://github.com/settings/keys" | xclip -sel clip
	echo "proceed with any key"
	read confirmation;
	echo "The new ssh key is now in your clipboard, just create a new one on the site."
	cat .ssh/id_rsa.pub | xclip -sel clip
	echo "proceed with any key"
	read confirmation;
	cat .ssh/id_rsa.pub | xclip -sel clip
	echo "Now we gonna connect to tigerly"
	echo "The **ONLY** thing you have to do now, after typing in the password, is to 'CRTL+(SHIFT)+V' and then 'CTRL+C'"
	echo "Tee is started and therefore you DO NOT NEED TO DO ANYTHING ELSE"
	echo "This will paste the generated ssh key into the authorized_keys file"
	echo "And therefore allow this computer from now on to connect to tigerly without a password"
	ssh manfild@tigerly -p 88 -t "cd .ssh; tee authorized_keys; bash --login"
fi

echo "Install rust? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source "$HOME/.cargo/env"
 	cargo install cargo-watch
  	cargo install cargo-deb
    	cargo install elf2uf2-rs
      	cargo install rustup target add thumbv6m-none-eabi
	cargo install probe-rs
fi

echo "Install shell? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install zsh fzf alacritty -y
	cargo install exa
	chsh -s /usr/bin/zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
    sudo rm -r \
        .bash_history \
        .bash_logout \
        .bashrc
fi

echo "Install utils (recomended)? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install tlp libudev-dev imagemagick -y
 	sudo apt remove nano
fi

echo "Install i3 custom de? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
        sudo add-apt-repository universe -y && sudo add-apt-repository ppa:agornostal/ulauncher -y && sudo apt update
	sudo apt install -y \
 		i3-wm \
   		i3blocks \
     	i3lock \
        network-manager-gnome \
	 	dunst \
   		flameshot \
        feh \
        imagemagick \
	 	fzf \
   		fd-find \
        ulauncher \
        pavucontrol \
	 	copyq \
   		ranger
 	sudo cp $HOME/dotfiles/.config/systemd/user/screenlock_pre@.service /etc/systemd/system/screenlock_pre@.service
 	sudo cp $HOME/dotfiles/.config/systemd/user/screenlock_post@.service /etc/systemd/system/screenlock_post@.service
  	sudo systemctl daemon-reload
 	sudo systemctl enable screenlock_pre@$SUDO_USER.service
  	sudo systemctl enable screenlock_post@$SUDO_USER.service
	sudo apt install xclip -y
    echo
	echo "Please go to the website in your clipboard and request an api key. After that, please provide it to the script."
	echo "https://api.nasa.gov/" | xclip -sel clip
    read nasa_api_key;
    echo "$nasa_api_key" > $HOME/dotfiles/.config/i3/nasa-api-key
    echo "\n#Custom entries\n\n$SUDO_USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/efibootmgr" >> /etc/sudoers
fi

echo "Install neovim? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable -y
	sudo apt update -y
	sudo apt install -y \
 		neovim \
		ripgrep
fi

echo "Clone WIP projects? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir $HOME/repos
 	cd $HOME/repos
 	git clone git@github.com:JonasFocke01/ruhige_waldgeraeusche.git
  	git clone git@github.com:JonasFocke01/remindy.git
fi

echo "Install solar-overview? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir $HOME/repos
    cd $HOME/repos
	git clone git@github.com:JonasFocke01/solar-overview.git repos/solar-overview
	cd $HOME/repos/solar-overview
	./linux_install_script.sh
fi

echo "Install Gaming suite? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install -y \
 		steam \
 		discord
fi

echo "Automount tigerly? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    echo "//tigerly/Allgemeine\040Daten /mnt/tigerly cifs username=manfild,password=DSsiKul24Sd,vers=2.0 0 0" | sudo tee -a /etc/fstab
fi

echo "Install nodeversionmanager? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
fi

echo "Install spotify? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
 	sudo apt update
	sudo apt install spotify -y
fi

echo "Install Vlc Player? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo apt install vlc -y
fi

# TODO: This should better be a job for Systemd
# TODO: This looks broken. Investigate
echo "Automount proton at startup? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	mkdir proton
	crontab -l > mycron
 	echo "TODO: rclone needs to be installed and configured"
 	echo "* * * * * rclone mount proton: proton --vfs-cache-mode writes" >> mycron
  	crontab mycron
 	rm mycron
fi

echo "Configure Systemd config? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
 	sudo cp $HOME/dotfiles/.config/systemd/logind.conf /etc/systemd/logind.conf
fi

echo "Install arduino-cli? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    cd $HOME/Desktop
    wget https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz
    mkdir ../.arduino-cli
    tar -xzf arduino-cli_latest_Linux_64bit.tar.gz -C ../.arduino-cli
    cd $HOME
    sed -i -e "\$s/\$/:\/home\/$(whoami)\/.arduino-cli/" .zshrc
fi

echo "Use my dotfiles? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
    sudo apt install stow -y
    cd $HOME/dotfiles
    stow --adopt .
    git restore .
    fc-cache -f -v
fi

echo "Remove default home dir clutter? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo rm -r \
        Documents \
        Music \
        Pictures \
        Videos \
        Public \
        Templates
fi

echo "Restart the system now? (y/n)"
read confirmation;
if [ $confirmation = "y" ]; then
	sudo shutdown -r now
fi


