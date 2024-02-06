#!/bin/bash
set -ex

# Select Xcode 14.2
sudo xcode-select --switch /Applications/Xcode14.2.app;

xcodebuild test -scheme MailCore -sdk iphonesimulator16.2 -destination "OS=16.2,name=iPhone 14" -derivedDataPath ./.build-ios
