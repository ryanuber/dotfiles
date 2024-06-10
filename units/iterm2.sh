#!/bin/bash
set -e

brew install iterm2

PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
mkdir -p "$PROFILES_DIR"
cp units/iterm2/Profiles.json "$PROFILES_DIR"
