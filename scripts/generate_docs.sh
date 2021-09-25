#!/bin/bash

# Deintegrate the pods
pod deintegrate

gem install jazzy

# Run jazzy
jazzy -c \
    --output ./docs \
    --build-tool-arguments -scheme,SwiftyPick \
    --min-acl internal

# Run pod install
pod install

# Sort files
perl ./scripts/sort.pl SwiftyPick.xcodeproj/
