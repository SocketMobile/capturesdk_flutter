# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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