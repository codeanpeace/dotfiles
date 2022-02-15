#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Run brewfile to install packages, apps, and fonts
brew bundle --file ./Brewfile

# Remove outdated versions from the cellar.
brew cleanup

# Zsh & Bash
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
sudo bash -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
sudo sh -c 'echo /opt/homebrew/bin/zsh >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /opt/homebrew/bin/zsh

# GNU core utilities
# Add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
ln -s "${BREW_PREFIX}/bin/greadlink" "${BREW_PREFIX}/bin/readlink"


# Quick look plugins
# see https://github.com/sindresorhus/quick-look-plugins
# if present, remove the quarantine attribute.
# Run this to see the attributes:
# `xattr -r ~/Library/QuickLook`
# And run this to remove the attributes:
# `xattr -d -r com.apple.quarantine ~/Library/QuickLook`


# Install Prezto
# git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# install zsh plugins
# install vim plugins :PlugInstall
# install tmux plugins <leader> I

# asdf to install elixir, erlang, ruby, python, node, lua

# todo: Create local .dotfiles git repo in Mackup folder
# remember to exclude all by default and whitelist in only dotfiles


# run osx.sh
# mackup restore