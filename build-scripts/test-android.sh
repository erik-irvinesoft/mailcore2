#!/usr/bin/env bash

set -e

function finish {
    exit_code=$?
    set +e

    adb -s $ANDROID_SERIAL emu kill

    cat ndk-stack.log
    rm -rf ndk-stack.log

    exit $exit_code
}
trap finish EXIT

# Create emulator if needed
$ANDROID_HOME/emulator/emulator -list-avds | grep -q $EMULATOR_NAME && echo "AVD $EMULATOR_NAME already exist" || avdmanager create avd -n $EMULATOR_NAME -k "$EMULATOR_PACKAGE" -d "pixel" --abi $EMULATOR_ABI

# Start emulator
$ANDROID_HOME/emulator/emulator -no-window -avd $EMULATOR_NAME -noaudio -port $EMULATOR_PORT -timezone America/Los_Angeles -partition-size 4000 > /dev/null &

# Wait until enmulator actually started with timeout 60 sec
timeout 60 adb wait-for-any-device

# Clear logcat from previous sessions
adb logcat -c || true

# Start write adb logcat to file
adb logcat | ndk-stack -sym .build/debug > ndk-stack.log &

# Force clean
rm -rf .build Package.resolved test.log

rm -rf ./build-android-swift/third-party
rm -rf ./build-android-swift/include
rm -rf ./build-android-swift/mailcore2-android-*.zip
rm -rf ./build-android-swift/cmake-build
rm -rf ./build-android-swift/libs
rm -rf ./build-android-swift/obj

# Build extrenal
swift-install

# Generate LinuxMain.swift
sourcery

# Build
pass_to_swiftc="-Xbuild -Xswiftc -Xbuild"
pass_to_frontend="$pass_to_swiftc -Xfrontend $pass_to_swiftc"

swift-test --deploy \
    $pass_to_frontend -experimental-disable-objc-attr

# Test
swift-test --just-run | tee test.log

return_code=${PIPESTATUS[0]}

cat test.log | xcpretty --report junit

cat ndk-stack.log

exit ${return_code}
