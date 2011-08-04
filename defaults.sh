#!/bin/bash

if [ ! `defaults read com.apple.finder AppleShowAllFiles` == "0" ]; then
  echo "Writing default: Don't show all files in finder..."
  defaults write com.apple.finder AppleShowAllFiles 0
  killall Finder
fi

if [ ! `defaults read com.apple.Safari IncludeDebugMenu` = "1" ]; then
  echo "Writing default: Show developer menu in Safari..."
  defaults write com.apple.Safari IncludeDebugMenu 1
  killall Safari
fi

if [ ! `defaults read com.apple.screencapture disable-shadow` = "1" ]; then
  echo "Writing default: Disable shadows on screenshots of windows..."
  defaults write com.apple.screencapture disable-shadow 1
  killall SystemUIServer
fi
