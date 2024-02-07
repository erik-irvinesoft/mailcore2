#!/bin/bash
set -ex

# Select Xcode 14.2
sudo xcode-select --switch /Applications/Xcode14.2.app;

# Create reports folder
mkdir -p .build-ios/reports

# Test
xcodebuild test -scheme MailCore \
	-sdk iphonesimulator16.2 \
	-destination "OS=16.2,name=iPhone 14" \
	-derivedDataPath ./.build-ios | tee .build-ios/reports/test.log
return_code=${PIPESTATUS[0]}

# Generate junit report
cat .build-ios/reports/test.log | xcpretty --report junit --output .build-ios/reports/junit.xml

# return code
exit ${return_code}