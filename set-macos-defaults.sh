#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set MacOS Defaults
# @raycast.mode fullOutput
# @raycast.packageName Dotfiles
#
# Optional parameters:
# @raycast.icon assets/extension-icon.png
# @raycast.iconDark assets/extension-icon.png
# Documentation:
# @raycast.description Sets MacOS defaults like dock customization, hot corners, etc.
# @raycast.author Jhey
# @raycast.authorURL https://x.com/jh3yy

echo "🔧 Setting macOS Defaults"

########################################
# Finder Preferences
########################################

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true  # May no longer work in newer macOS

########################################
# Security
########################################

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

########################################
# Energy (Mostly Obsolete)
########################################

sudo pmset -a sms 0  # Only applies to HDDs

########################################
# Dock Customization
########################################

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 128
defaults write com.apple.dock tilesize -int 16
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool true
defaults write com.apple.dock launchanim -bool true
defaults write com.apple.dock mineffect -string "genie"
defaults write com.apple.dock minimize-to-application -bool false

########################################
# Window Behavior
########################################

defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"

########################################
# Keyboard & Input
########################################

defaults write NSGlobalDomain KeyRepeat -int 0
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write -g com.apple.trackpad.scaling -float 3.0
defaults write NSGlobalDomain com.apple.mouse.doubleClickThreshold -float 0.5

########################################
# Trackpad Settings
########################################

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Force Click & Haptic
defaults write com.apple.trackpad.forceClick -bool true
defaults write -g com.apple.trackpad.forceClick -bool true

# Scroll & Zoom
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1

# More Gestures
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadAppExposeGesture -int 2
defaults write com.apple.dock showMissionControlGestureEnabled -int 1
defaults write com.apple.dock showLaunchpadGestureEnabled -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 1

########################################
# Hot Corners
#  0: No-op
#  3: Mission Control
#  4: Desktop
# 10: Display Sleep
########################################

defaults write com.apple.dock "wvous-bl-corner" -int 4
defaults write com.apple.dock "wvous-bl-modifier" -int 0
defaults write com.apple.dock "wvous-br-corner" -int 10
defaults write com.apple.dock "wvous-br-modifier" -int 0
defaults write com.apple.dock "wvous-tl-corner" -int 3
defaults write com.apple.dock "wvous-tl-modifier" -int 0
defaults write com.apple.dock "wvous-tr-corner" -int 4
defaults write com.apple.dock "wvous-tr-modifier" -int 0

########################################
# Terminal Settings
########################################

defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

########################################
# Chrome Settings
########################################

defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

########################################
# Safari Developer Settings
########################################

defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari ShowFavoritesBar -bool false

########################################
# Screenshot Location
########################################

mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location "${HOME}/Screenshots"

########################################
# Save to Disk (not iCloud) by Default
########################################

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

########################################
# Spring-loading in Finder
########################################

defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

########################################
# Restart Affected Applications
########################################

killall Finder Dock Terminal SystemUIServer