# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

<!--new item here (do not remove)-->

## [1.4.44] - 2024-02-06

### Added

- Enabled Start Capture Service on Android.

## [1.4.17] - 2023-10-16

### Added

- Added support for SocketCam C820.
- Added support for S370 and S550.
- Added support for M930 and M940.

## [1.3.17] - 2023-04-12

### Added

- Fixed gradle issues.
- Added check for battery level property.

## [1.3.1] - 2022-09-07

### Added

- Updated references from 'capturesdk' to 'capturesdk_flutter'.

## [1.3.0] - 2022-09-06

### Added

- Changed package name to avoid conflict with iOS SDK naming.

## [1.2.105] - 2022-05-17

### Added

- Fixed hot reload issue on iOS.
- Added default logger so user doesn't have to include their own.

## [1.2.84] - 2022-03-29

### Added

- Updated changelog and added changelog additional line logic.

## [1.2.83] - 2022-03-29

### Added

- Updated README.md title to be consistent with other references.

## [1.2.80] - 2022-03-29

### Added

- Updated README.md to include updated get and setFriendlyName functions.
- Updated image links in README.md to reference githubusercontent link instead of relative path (pub.dev is currently working on not just defaulting to master because repos sometimes use another name, such as main).

## [1.2.78] - 2022-03-25

### Added

- Updated description for package.

## [1.2.77] - 2022-03-25

### Added

- Updated pubspec and podspec descriptions to be at least 60 characters long.
- Updated license to try and be MIT.

## [1.2.76] - 2022-03-24

### Added

- renamed name in podspec from 'CaptureSDK' to 'capturesdk'.

## [1.2.75] - 2022-03-24

### Added

- renamed podspec from 'capture_flutter_beta.podspec' to 'capturesdk.podspec'.

## [1.2.74] - 2022-03-24

### Added

- Changing name of flutter sdk for pub package from 'capture_flutter_beta' to 'capturesdk'.

## [1.2.57] - 2022-03-23

### Added

- Reverted changes to just include README update.

## [1.2.56] - 2022-03-23

### Added

- Included module for SKTCaptureObjC into root iOS/pods file.

## [1.2.55] - 2022-03-23

### Added

- New import syntax for Transport.h.

## [1.2.54] - 2022-03-23

### Added

- Changing format in Objective C file to import SktCapture as module.

## [1.2.53] - 2022-03-23

### Added

- Changing format in Objective C file to import SktCapture as module.

## [1.2.52] - 2022-03-23

### Added

- changing version.

## [1.2.51] - 2022-03-23

### Added

- working on fixing ios issues.
- Removing need for non-modular-headers constraint.

## [1.2.43] - 2022-03-18

### Added

- Refined versioning logic in generate_consts.sh.
- Updated version and changelog.

## [1.2.35] - 2022-03-17

### Added

- Removed unused build.sh and gitlab-ci logic.

## [1.2.31] - 2022-03-15

### Added

- Re-added generate_consts.sh.
- Shell script can now update and prepare flutter package for publication on pub.dev.

## [1.2.28] - 2022-03-10

### Added

- Updated appinfo in README and example code.
- Resolving outstanding threads in [merge request](https://git.socketmobile.com/capture/capturesdk-flutter/-/merge_requests/3).

## [1.2.21] - 2022-03-10

### Added

- Updated git versioning logic.
- Updated docs for Socket Mobile Website.
- Updated config.py file to include commit number in version in documentation.

## [1.2.1] - 2022-02-24

### Added

- Updated README.md to include iOS instructions for initializing app before installing package.

## [1.2.0] - 2022-02-24

### Added

- Updated README.md to include iOS instructions for initializing app before installing package.

## [1.1.9] - 2022-02-18

### Added

- Updated generate_consts.sh to update version in README.md.
- Updated generate_consts.sh to allow either git subtree pull... or generate constants.

## [1.1.8] - 2022-02-18

### Added

- Updated repo url for pub.dev (made a public snapshot).

## [1.1.7] - 2022-02-18

### Added

- Specifying and updating dart doc comments to improve pubscore.
- Dart doc comments added for capture.dart, http_transport.dart, ios_transport_adaptor.dart.

## [1.1.6] - 2022-02-18

### Added

- Continued updating for dart doc comments throughout API.

## [1.1.5] - 2022-02-18

### Added

- Need to fix formatting in templates for constants.

## [1.1.4] - 2022-02-17

### Added

- Added more dart doc comments.

## [1.1.3] - 2022-02-17

### Added

- Included git subtree for capture constants.
- Implementing shell script to run python code in subtree AND update version number.

## [1.1.2] - 2022-02-03

### Added

- Formatted dart code.
- Changed to async...await format for Futures.
- Unified error handling to return either CaptureException or CaptureEvent.
- Strictly typed Futures.
- Updated pigeon and iOS files to enable cross platform usage.

## [1.1.1] - 2022-01-07

### Added

- Formatted dart code.
- Refined ios error handling and response handling in capture.

## [1.1.0] - 2022-01-05

### Added

- Formatted dart code.
- Removed excess comments.
- Used dartdoc to generate dart API documentation for pub.dev.

## [1.0.9] - 2022-01-04

### Added

- Included code for ios platform used in plugin found [here](https://git.socketmobile.com/Kitchen-sink/testcaptureflutter/-/tree/main/).
- Improved API documentation for pub.dev.
- Updated README.md to include link to app regstration.

## [1.0.8] - 2021-12-15

### Added

- Reformatted dart files to be compatible with pub.dev formatting rules.

## [1.0.7] - 2021-12-10

### Added

- Removed unused dependencies `build_verify` and `cupertino_icons`.

## [1.0.6] - 2021-12-08

### Added

- Updated code to not have to rely on `dart:convert` in clientside.
- Updated example.

## [1.0.5] - 2021-12-08

### Added

- Updated README.md.

## [1.0.4] - 2021-12-08

### Added

- Updated example and remove unused code.
- Updated README.md.

## [1.0.3] - 2021-12-08

### Added

- Unignoring lib/classes to allow access to classes.

## [1.0.2] - 2021-12-08

### Added

- Hiding unneeded files from pub.dev.
- Rewriting exports for new file structure.
- Added capture_flutter_beta.dart to make package import more clearly defined.

## [1.0.1] - 2021-12-08

### Added

- Updated README.md to reference correct package name and version.
- Added example code for pub.dev.

## [1.0.0+1] - 2021-12-07

### Added

- First Publish (Beta release).
- Package provides a Flutter based SDK to interact with Socket Mobile's Capture Library.
