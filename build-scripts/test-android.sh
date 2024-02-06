#!/bin/bash

set -ex

# Create variables
export SWIFT_ANDROID_HOME=$SWIFT_ANDROID_HOME_5_7
export SWIFT_ANDROID_API_LEVEL=26
export SWIFT_ANDROID_ICU_VERSION=73
export ANDROID_NDK=$ANDROID_NDK_ROOT_25C
export ANDROID_NDK_ROOT=$ANDROID_NDK
export ANDROID_NDK_HOME=$ANDROID_NDK

# Update PATH
export PATH=$ANDROID_NDK:$PATH
export PATH=$SWIFT_ANDROID_HOME/bin:$SWIFT_ANDROID_HOME/build-tools/current:$PATH

# Emulator
export BUILD_ANDROID=1
export EMULATOR_PORT=5558
export EMULATOR_SDK_VERSION=29
export EMULATOR_NAME=ci-test-$EMULATOR_SDK_VERSION-$EMULATOR_PORT
export ANDROID_SERIAL=emulator-$EMULATOR_PORT
if [[ $(uname -m) == 'arm64' ]]; then
  export SWIFT_ANDROID_ARCH=aarch64
  export EMULATOR_ARCH=arm64-v8a
else
  export SWIFT_ANDROID_ARCH=x86_64
  export EMULATOR_ARCH=x86_64
fi
export EMULATOR_PACKAGE="system-images;android-$EMULATOR_SDK_VERSION;google_apis;$EMULATOR_ARCH"
export EMULATOR_ABI=google_apis/$EMULATOR_ARCH

# Select Xcode 14.2
sudo xcode-select --switch /Applications/Xcode14.2.app;

function finish {
  exit_code=$?
    adb -s $ANDROID_SERIAL emu kill
    exit $exit_code
}
trap finish EXIT

# Delete emulator if needed
if $ANDROID_HOME/emulator/emulator -list-avds | grep -q $EMULATOR_NAME
then
    avdmanager delete avd --name $EMULATOR_NAME
fi

# Just in case
rm -rf ~/.android/avd/$EMULATOR_NAME.avd

avdmanager create avd -n $EMULATOR_NAME -k "$EMULATOR_PACKAGE" -d "pixel" --abi $EMULATOR_ABI

# Start adb server
adb start-server

# Start emulator
$ANDROID_HOME/emulator/emulator -no-window -avd $EMULATOR_NAME -noaudio -port $EMULATOR_PORT -timezone America/Los_Angeles -partition-size 4000 > /dev/null &

# Wait until enmulator actually started with timeout 60 sec
timeout 120 adb -s emulator-$EMULATOR_PORT wait-for-any-device;

# Clear logcat from previous sessions
timeout 30 bash -c "adb logcat -c || true"

# Start write adb logcat to file
adb logcat | ndk-stack -sym .build/debug > ndk-stack.log &

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
