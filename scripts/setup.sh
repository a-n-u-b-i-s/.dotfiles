#!/bin/bash

# Imports

# Color SETAFs
RED_SETAF=1;
GREEN_SETAF=2;
YELLOW_SETAF=3;
BLUE_SETAF=4;
PINK_SETAF=5;
CYAN_SETAF=6;
WHITE_SETAF=7;

# Color Tags
RED=$(tput setaf $RED_SETAF)
GREEN=$(tput setaf $GREEN_SETAF)
YELLOW=$(tput setaf $YELLOW_SETAF)
BLUE=$(tput setaf $BLUE_SETAF)
PINK=$(tput setaf $PINK_SETAF)
CYAN=$(tput setaf $CYAN_SETAF)
WHITE=$(tput setaf $WHITE_SETAF)
NC=$(tput sgr0)

# Welcome Message
echo "$BLUE
      _       _    __ _ _           
   __| | ___ | |_ / _(_) | ___  ___
  / _\` |/ _ \\| __| |_| | |/ _ \\/ __|
 | (_| | (_) | |_|  _| | |  __/\__ \\
  \\__,_|\\___/ \\__|_| |_|_|\\___||___/
$NC"

#  _                 _       _                   
# | |__   ___   ___ | |_ ___| |_ _ __ __ _ _ __  
# | '_ \ / _ \ / _ \| __/ __| __| '__/ _` | '_ \ 
# | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) |
# |_.__/ \___/ \___/ \__|___/\__|_|  \__,_| .__/ 
#                                         |_|    
#
#

#!/usr/bin/env zsh

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
echo "${RED}Need Sudo Password to Force Update System Preferences$NC"
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Update Software
softwareupdate -i -a

# Install XCode Developer Tools
xcode-select --install

# General UI/UX

echo "
${GREEN}Enter the name for your machine$NC"
read machine_name

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $machine_name
sudo scutil --set HostName $machine_name 
sudo scutil --set LocalHostName $machine_name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $machine_name

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Always show scrollbars when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Set Icon Size
defaults write com.apple.dock "tilesize" -int "36"

# Autohide Dock
defaults write com.apple.dock "autohide" -bool "true"

# Instant Autohide
defaults write com.apple.dock "autohide-time-modifier" -float "0"
defaults write com.apple.dock "autohide-delay" -float "0"

# Hide Recent Apps from Dock
defaults write com.apple.dock "show-recents" -bool "false"

# Cool Minimize Effect
defaults write com.apple.dock "mineffect" -string "suck"

# Adjust toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# Screen

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Hide Desktop Icons
defaults write com.apple.finder CreateDesktop false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Notification Center
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Launchpad
defaults write com.apple.dock wvous-bl-corner -int 11
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → Start screen saver
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

# Safari & WebKit

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Spotlight
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

# Activity Monitor

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Setup Empty File Paths
mkdir -p ~/dev/archive
mkdir -p ~/auth/recovery-codes
mkdir -p ~/auth/google-service-accounts
mkdir -p ~/fun
mkdir -p ~/Documents/Wallpaper
mkdir -p ~/Documents/Music
mkdir -p ~/Documents/Personal
mkdir -p ~/Documents/Work

#  _           _        _ _ 
# (_)_ __  ___| |_ __ _| | |
# | | '_ \/ __| __/ _` | | |
# | | | | \__ \ || (_| | | |
# |_|_| |_|___/\__\__,_|_|_|
#                           

# Install Homebrew Packages
brew bundle install --file=$(dirname "${BASH_SOURCE[0]}")/Brewfile

# Setup Fish Shell
sudo echo /opt/homebrew/bin/fish >> /etc/shells
chsh -s /opt/homebrew/bin/fish

# Decrypt GPG Key
mkdir -p $(dirname "${bash_source[0]}")/../secrets/decrypted
openssl enc -d -aes-256-cbc -in $(dirname "${BASH_SOURCE[0]}")/../secrets/encrypted/private.key.enc -out $(dirname "${BASH_SOURCE[0]}")/../secrets/decrypted/private.key
/opt/homebrew/bin/gpg --import $(dirname "${bash_source[0]}")/../secrets/decrypted/private.key 

# Decrypt Encrypted Secrets
/opt/homebrew/bin/gpg --decrypt $(dirname "${BASH_SOURCE[0]}")/../secrets/encrypted/locked.gpg > $(dirname "${BASH_SOURCE[0]}")/../secrets/encrypted/unlocked.tar.gz
tar xzf $(dirname "${BASH_SOURCE[0]}")/../secrets/encrypted/unlocked.tar.gz -C $(dirname "${BASH_SOURCE[0]}")/../secrets

# Add Neovim Config Folder
mkdir -p ~/.config/nvim

# Setup Symlinks
$(dirname "${BASH_SOURCE[0]}")/../install;

