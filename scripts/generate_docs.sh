#!/bin/bash

# Deintegrate the pods
pod deintegrate

# Run jazzy
jazzy -c \
    --output Documentation/jazzy \
    --build-tool-arguments -scheme,SwiftyPick \
    --min-acl internal

# Run pod install
pod install

# Sort files
perl ./scripts/sort.pl SwiftyPick.xcodeproj/