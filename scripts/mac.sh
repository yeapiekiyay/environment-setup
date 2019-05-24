#!/bin/bash

# Casks to install with brew
casksToInstall=(
1password
atom
bitwarden
firefox-developer-edition
google-chrome
iterm2
keybase
spotify
steam
)

brewTaps=(
homebrew/cask-versions
)

# Install brew, if it isn't installed already
if [[ ! $(command -v brew) ]]; then
  echo "Installing brew..."

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Get tapped taps
installedBrewTaps=$(brew tap)

# Tap a brew tap (use it as a source for brew packages)
tap() {
  local tap_name=$1

  if [[ $installedBrewTaps != *$tap_name* ]]; then
    echo "Tapping $tap_name..."

    brew tap $tap_name
  else
    echo "$tap_name already tapped!"
  fi
}

for tap in "${brewTaps[@]}"; do
  tap "$tap"
done

# Get installed casks
installedCasks=$(brew cask list)

install_cask() {
  local cask_name=$1

  if [[ $installedCasks != *$cask_name* ]]; then
    echo "Installing $cask_name..."

    brew cask install $cask_name
  else
    echo "$cask_name already installed!"
  fi
}

# Install the casks
for cask in "${casksToInstall[@]}"; do
  install_cask "$cask"
done
