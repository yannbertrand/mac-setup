echo "#----------------------------------------#"
echo "#             Switch to ZSH              #"
echo "#----------------------------------------#"
[ "$GITHUB_ACTIONS" != true ] && chsh -s /bin/zsh

echo "#----------------------------------------#"
echo "#   Installing Apple Command Line Tools  #"
echo "#----------------------------------------#"
[ "$GITHUB_ACTIONS" != true ] && xcode-select --install

echo "#----------------------------------------#"
echo "#           Installing Homebrew          #"
echo "#----------------------------------------#"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # See https://brew.sh/

echo "#----------------------------------------#"
echo "#  Installing some utilities using Brew  #"
echo "#----------------------------------------#"
[ "$GITHUB_ACTIONS" != true ] && brew install yarn
brew install git
brew install openssl
brew install mas        # See https://github.com/mas-cli/mas
brew install youtube-dl # See https://github.com/ytdl-org/youtube-dl
brew install bat        # See https://github.com/sharkdp/bat
brew install nvm        # See https://github.com/creationix/nvm

echo "# Installing Node.js using nvm"
[ "$GITHUB_ACTIONS" != true ] && nvm install node

echo "#----------------------------------------#"
echo "# Installing apps from the Mac App Store #"
echo "#----------------------------------------#"
if [ "$GITHUB_ACTIONS" != true ] ; then
  mas lucky Gifski              # See https://sindresorhus.com/gifski
  mas lucky Lungo               # See https://sindresorhus.com/lungo
  mas lucky "Battery Indicator" # See https://sindresorhus.com/battery-indicator
  mas lucky "Paste 2"           # See https://pasteapp.me/
  mas lucky "Avast Passwords"   # See https://avast.com/passwords
  mas lucky Shotty              # See https://jacobruiz.com/shotty
  mas lucky "The Unarchiver"    # See https://macpaw.com/the-unarchiver
  mas lucky Expressions         # See https://www.apptorium.com/expressions
  mas lucky Quiver              # See http://happenapps.com/#quiver
  mas lucky Magnet              # See https://magnet.crowdcafe.com/
  mas lucky "PiPifier - PiP for nearly every video" # See https://github.com/arnoappenzeller/PiPifier
fi

echo "#----------------------------------------#"
echo "#       Installing some Brew casks       #"
echo "#----------------------------------------#"
brew cask install docker
brew cask install brave-browser      # See https://brave.com/
brew cask install sublime-text       # See https://sublimetext.com/
brew cask install visual-studio-code # See https://code.visualstudio.com/
brew cask install station            # See https://getstation.com/
brew cask install cleanmymac         # See https://macpaw.com/cleanmymac
brew cask install vlc                # See https://videolan.org/vlc/
brew cask install transmission       # See https://transmissionbt.com/
brew cask install molotov            # See https://www.molotov.tv/
brew cask install cyberduck          # See https://cyberduck.io/
brew cask install bartender          # See https://www.macbartender.com/
brew cask install protonmail-bridge  # See https://protonmail.com/bridge/
brew cask install protonvpn          # See https://protonvpn.com/
brew cask install handbrake          # See https://handbrake.fr/
brew cask install gitkraken          # See https://www.gitkraken.com/
brew cask install iterm2             # See https://iterm2.com/
brew cask install kap                # See https://getkap.co/
brew cask install colorsnapper       # See https://colorsnapper.com/
brew cask install aerial             # See https://github.com/JohnCoates/Aerial

echo "#----------------------------------------#"
echo "#         Initialising dev stuff         #"
echo "#----------------------------------------#"

echo "# Initialising ~/.gitignore"
echo ".DS_Store" >> ~/.gitignore

echo "# Initialising ~/.zshrc"
cat >~/.zshrc <<EOL
#!/bin/zsh

export ZSH_CONF="default"
export PS1="%n:%1~$ "

alias cat=bat

EOL

echo "#----------------------------------------#"
echo "#         Setting up your SSH key        #"
echo "#----------------------------------------#"
if [ -z "$1" ]
  then
    echo "> What email would you like to use?"
    read email
else
  email=$1
fi

ssh-keygen -q -t rsa -b 4096 -C $email -f $HOME/.ssh/id_rsa -N ""

echo "Copy/paste it on https://github.com/settings/ssh/new"
cat ~/.ssh/id_rsa.pub
