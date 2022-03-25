#!/usr/bin/env bash -l
#
#  build script to build the Flutter Capture SDK
#
#  The argument should be the path of the project directory
#
# (c) 2019 Socket Mobile, all rights reserved.
#

# Postitional arguments

PROJECT_DIR="${1:-${PWD}}"
BUILD_CONFIG=${2:-Release}
BUILDSCRIPTS_DIR="$PROJECT_DIR/buildscripts"
buildNumber=${BUILD_NUMBER:-"0"}

gitVersion=`git describe --long | awk '{split($0,a,"-"); print a[1] "." a[2]}' | awk '{split($0,a,"."); print a[1] "." a[2]}'`
gitRevision=`git describe --long | awk '{split($0,a,"-"); print a[1] "." a[2]}' | awk '{split($0,a,"."); print a[3] + a[4]}'`

[[ "$(command -v dart)" ]] || { 
    echo "installing Dart"
    brew tap dart-lang/dart
    brew install dart
    1>&2 ; 
    echo "Dart Installed."; 
}

[[ "$(command -v flutter)" ]] || { 
    echo "installing Flutter" 
    brew install flutter
    1>&2 ; 
    echo "Flutter Installed."; 
}

dateValue=$(date "+%Y/%m/%d %H:%M:%S")
year=$(date "+%Y")
echo "/* CaptureFlutter version ${gitVersion}.${gitRevision}.${buildNumber} ${dateValue} © ${year} Socket Mobile, inc. */" > versiontext.dart
captureFlutterName="CaptureFlutter-${gitVersion}.${gitRevision}.${buildNumber}"