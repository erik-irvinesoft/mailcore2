#!/bin/bash
set -ex

# Select Xcode 14.2
sudo xcode-select --switch /Applications/Xcode14.2.app;

export UNIT_TEST=1

swift test
