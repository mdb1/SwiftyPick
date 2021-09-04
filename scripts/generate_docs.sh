#!/bin/bash

# Deintegrate the pods
pod deintegrate

# Run jazzy
jazzy -c --output Documentation/jazzy

# Run pod install
pod install