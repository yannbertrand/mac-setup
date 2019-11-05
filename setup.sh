echo "# Installing homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "# Installing some utilities"
brew install mas
brew install git
brew install yarn
brew install openssl
brew install youtube-dl
brew install nvm

echo "# Setting up nvm"
mkdir ~/.nvm
echo "export NVM_DIR=\"$HOME/.nvm\"" >> ~/.bash_profile
echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\" # This loads nvm" >> ~/.bash_profile

echo "# Installing node"
nvm install --lts # Long-term support

echo "# Installing apps from the Mac App Store"
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

echo "Installing homebrew cask"
brew tap homebrew/cask

echo "Installing some casks"
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

if [ -z "$1" ]
  then
    echo "Setting up your SSH key"
    echo "What email would you like to use?"
    read email
else
    email=$1
fi

echo "Generating SSH key"
ssh-keygen -q -t rsa -b 4096 -C $email -f $HOME/.ssh/id_rsa -N ""
