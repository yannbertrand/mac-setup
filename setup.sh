whoami

echo "#----------------------------------------#"
echo "#             Switch to ZSH              #"
echo "#----------------------------------------#"
chsh -s /bin/zsh

echo "#----------------------------------------#"
echo "#   Installing Apple Command Line Tools  #"
echo "#----------------------------------------#"
xcode-select --install

echo "#----------------------------------------#"
echo "#           Installing Homebrew          #"
echo "#----------------------------------------#"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "#----------------------------------------#"
echo "#  Installing some utilities using Brew  #"
echo "#----------------------------------------#"
brew install mas
brew install git
brew install yarn
brew install openssl
brew install youtube-dl
brew install bat
brew install nvm

echo "#----------------------------------------#"
echo "# Installing apps from the Mac App Store #"
echo "#----------------------------------------#"
mas lucky Gifski
mas lucky Lungo
mas lucky "Battery Indicator"
mas lucky "Paste 2"
mas lucky "Avast Passwords"
mas lucky Shotty
mas lucky "The Unarchiver"
mas lucky Expressions
mas lucky Quiver
mas lucky "PiPifier - PiP for nearly every video"
mas lucky Magnet

echo "#----------------------------------------#"
echo "#       Installing some Brew casks       #"
echo "#----------------------------------------#"
brew cask install brave-browser
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install station
brew cask install cleanmymac
brew cask install vlc
brew cask install transmission
brew cask install molotov
brew cask install cyberduck
brew cask install bartender
brew cask install protonmail-bridge
brew cask install protonvpn
brew cask install handbrake
brew cask install docker
brew cask install gitkraken
brew cask install iterm2
brew cask install kap
brew cask install colorsnapper

if [ -z "$1" ]
  then
    echo "#----------------------------------------#"
    echo "#         Setting up your SSH key        #"
    echo "#----------------------------------------#"
    echo "> What email would you like to use?"
    read email
else
    email=$1
fi

echo "# Installing Node.js"
nvm install node

echo "# Initialising ~/.gitignore"
echo ".DS_Store\n" >> ~/.gitignore

echo "# Initialising ~/.zshrc"
echo '#!/bin/zsh' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'export ZSH_CONF="default"' >> ~/.zshrc
echo 'export PS1="%n:%1~$ "' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'alias cat=bat' >> ~/.zshrc
echo '' >> ~/.zshrc

echo "#----------------------------------------#"
echo "#           Generating SSH key           #"
echo "#----------------------------------------#"
ssh-keygen -q -t rsa -b 4096 -C $email -f $HOME/.ssh/id_rsa -N ""
