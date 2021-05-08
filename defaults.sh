#!/bin/bash

echo "Writing default: Show developer menu in Safari..."
defaults write com.apple.Safari IncludeDebugMenu 1

echo "Writing default: Don't remember open windows in Safari..."
defaults write com.apple.Safari NSQuitAlwaysKeepsWindows 0

killall Safari

# Make Library visible
chflags nohidden ~/Library/
