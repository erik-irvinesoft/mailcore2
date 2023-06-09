#!/bin/sh
set -x

pushd "`dirname "$0"`" > /dev/null
scriptpath="`pwd`"
popd > /dev/null

. "$scriptpath/include.sh/build-dep.sh"

url="git@github.com:readdle/libetpan.git"
rev=2c1a809ee35d43395fa2b0578d80103a94150260
name="libetpan-ios"
xcode_target="libetpan ios"
xcode_project="libetpan.xcodeproj"
library="libetpan-ios.a"
xcframework="libetpan-ios.xcframework"
embedded_deps="libsasl-ios"

build_git_ios
