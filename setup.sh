echo "#----------------------------------------#"
echo "#         Initialising Mac config        #"
echo "#----------------------------------------#" 
# See https://www.defaults-write.com

echo "Disable Gatekeeper"
[ "$GITHUB_ACTIONS" != true ] && defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false

echo "Enable Safari debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu 1

echo "Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean true

echo "Disable ‘Stay on front’ for help windows"
defaults write com.apple.helpviewer DevMode -bool true

echo "Disable the creation of .DS_Store files"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

echo "# Dock"
echo " Sets the Dock to the left"
defaults write com.apple.dock "orientation" -string "left"
echo " Autohide the Dock"
defaults write com.apple.dock "autohide" -bool "true"
echo " Remove the Auto-Hide & Show Delay"
defaults write com.apple.Dock autohide-delay -float 0
echo " Decrease the Mission Control zoom effect in Mac OS X"
defaults write com.apple.dock expose-animation-duration -float 0.12
echo " Relaunch"
killall Dock

echo "# Finder"
echo " Display the file extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo " Display full posix path title Bar"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
echo " Change default view style to Column View"
defaults write com.apple.Finder FXPreferredViewStyle clmv
echo " Display folders before files"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
echo " Relaunch"
killall Finder

echo "# Screenshots"
mkdir ~/Pictures/Screenshots
echo " Disable screenshot shadows on a Mac"
defaults write com.apple.screencapture disable-shadow -bool true
echo " Remove the date and timestamp from Screenshots"
defaults write com.apple.screencapture include-date -bool false
echo " Change the default location for screenshots to ~/Pictures/Screenshots"
defaults write com.apple.screencapture location ~/Pictures/Screenshots
echo " Relaunch SystemUIServer"
killall SystemUIServer

echo "#----------------------------------------#"
echo "#   Installing Apple Command Line Tools  #"
echo "#----------------------------------------#"
[ "$GITHUB_ACTIONS" != true ] && xcode-select --install

echo "#----------------------------------------#"
echo "#          Installing Oh My Zsh          #"
echo "#----------------------------------------#"
/bin/sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "#----------------------------------------#"
echo "#           Installing Homebrew          #"
echo "#----------------------------------------#"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # See https://brew.sh/

echo "#----------------------------------------#"
echo "#  Installing some utilities using Brew  #"
echo "#----------------------------------------#"
[ "$GITHUB_ACTIONS" != true ] && brew install yarn
brew install mas        # See https://github.com/mas-cli/mas
brew install youtube-dl # See https://github.com/ytdl-org/youtube-dl
brew install bat        # See https://github.com/sharkdp/bat
brew install asdf       # See https://github.com/asdf-vm/asdf

echo "# Installing Node.js using asdf"
[ "$GITHUB_ACTIONS" != true ] && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
[ "$GITHUB_ACTIONS" != true ] && echo "legacy_version_file = yes" > ~/.asdfrc

echo "#----------------------------------------#"
echo "# Installing apps from the Mac App Store #"
echo "#----------------------------------------#"
if [ "$GITHUB_ACTIONS" != true ] ; then
  mas lucky Gifski              # See https://sindresorhus.com/gifski
  mas lucky Lungo               # See https://sindresorhus.com/lungo
  mas lucky "Avast Passwords"   # See https://avast.com/passwords
  mas lucky "The Unarchiver"    # See https://macpaw.com/the-unarchiver
  mas lucky Expressions         # See https://www.apptorium.com/expressions
  mas lucky Quiver              # See http://happenapps.com/#quiver
  mas lucky colorslurp          # See https://colorslurp.com/
  mas lucky "PiPifier - PiP for nearly every video" # See https://github.com/arnoappenzeller/PiPifier
fi

echo "#----------------------------------------#"
echo "#       Installing some Brew casks       #"
echo "#----------------------------------------#"
brew install docker
brew install sublime-text       # See https://sublimetext.com/
brew install visual-studio-code # See https://code.visualstudio.com/
brew install ferdi              # See https://getferdi.com/
brew install cleanmymac         # See https://macpaw.com/cleanmymac
brew install disk-inventory-x   # See http://www.derlien.com/
brew install vlc                # See https://videolan.org/vlc/
brew install transmission       # See https://transmissionbt.com/
brew install molotov            # See https://www.molotov.tv/
brew install cyberduck          # See https://cyberduck.io/
brew install rectangle          # See https://rectangleapp.com
brew install bartender          # See https://www.macbartender.com/
brew install protonmail-bridge  # See https://protonmail.com/bridge/
brew install protonvpn          # See https://protonvpn.com/
brew install handbrake          # See https://handbrake.fr/
brew install gitkraken          # See https://www.gitkraken.com/
brew install iterm2             # See https://iterm2.com/
brew install aerial             # See https://github.com/JohnCoates/Aerial
brew install monitorcontrol     # See https://github.com/MonitorControl/MonitorControl

echo "#----------------------------------------#"
echo "#         Initialising dev stuff         #"
echo "#----------------------------------------#"

echo "# Creating Developer folder"
mkdir -p ~/Developer

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
