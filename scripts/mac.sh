#!/bin/bash

# Packages to install with brew cask
packagesToInstall=(
1password
atom
bitwarden
firefox-developer-edition
google-chrome
iterm2
keybase
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

# Get installed packages
installedPackages=$(brew cask list)

install_cask_package() {
  local package_name=$1

  if [[ $installedPackages != *$package_name* ]]; then
    echo "Installing $package_name..."

    brew cask install $package_name
  else
    echo "$package_name already installed!"
  fi
}

# Install the packages
for package in "${packagesToInstall[@]}"; do
  install_cask_package "$package"
done
