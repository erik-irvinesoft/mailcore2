#!/bin/sh
set -x

pushd "`dirname "$0"`" > /dev/null
scriptpath="`pwd`"
popd > /dev/null

. "$scriptpath/include.sh/build-dep.sh"

url="git@github.com:readdle/libetpan.git"
rev=94654ca70403fdbad8374b8921e0788cdce8709b
name="libetpan-osx"
xcode_target="static libetpan"
xcode_project="libetpan.xcodeproj"
library="libetpan.a"
embedded_deps=""

build_git_osx
