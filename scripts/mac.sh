#!/bin/bash

# Formulae to install with brew
formulaeToInstall=(
python3
)

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

pythonPackagesToInstall=(
powerline-status
)

# Brew taps to use
brewTaps=(
homebrew/cask-versions
)

# Install brew, if it isn't installed already
if [[ ! $(command -v brew) ]]; then
  echo "Installing brew..."

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Get installed formulae
installedFormulae=$(brew list)

install_formula() {
  local formula_name=$1

  if [[ $installedFormulas != *$formula_name* ]]; then
    echo "Installing $formula_name..."

    brew install $formula_name
  else
    echo "$formula_name already installed!"
  fi
}

# Install the formulae
for formula in "${formulaeToInstall[@]}"; do
  install_formula $formula
done

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
  tap $tap
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
  install_cask $cask
done

installedPythonPackages=$(pip3 list)

install_python_package() {
  local package_name=$1

  if [[ $installedPythonPackages != *$package_name* ]]; then
    echo "Installing $package_name..."

    pip3 install $package_name
  else
    echo "$package_name already installed!"
  fi
}

# Install python packages
for package in "${pythonPackagesToInstall[@]}"; do
  install_python_package $package
done

# TODO: Configure powerline-status programmatically: https://medium.com/@ITZDERR/how-to-install-powerline-to-pimp-your-bash-prompt-for-mac-9b82b03b1c02
