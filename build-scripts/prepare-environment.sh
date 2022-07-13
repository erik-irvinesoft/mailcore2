#!/usr/bin/env bash

set -x

# Create variables
export TOOLCHAINS=org.swift.540202104261a
export SWIFT_ANDROID_HOME=$SWIFT_ANDROID_HOME_5_4_R3
export SWIFT_ANDROID_API_LEVEL=26
export ANDROID_NDK=$ANDROID_NDK_ROOT_21E
export ANDROID_NDK_ROOT=$ANDROID_NDK
export ANDROID_NDK_HOME=$ANDROID_NDK

# Update PATH
export PATH=$ANDROID_NDK:$PATH
export PATH=$SWIFT_ANDROID_HOME/bin:$SWIFT_ANDROID_HOME/build-tools/current:$PATH

# Emulator
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