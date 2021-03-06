# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.12] - 2020-08-25
### Added
- Added ARMv7 image. Unified Dockerfile for both architectures to take advantage of buildx

## [0.0.11] - 2020-08-23
### Changed
- Bumped duplicacy_web version to 1.4.1. `DWE_PASSWORD` is no longer required; updated readme accordingly.

## [0.0.10] - 2020-08-07
### Changed
- Bumped duplicacy_web version to 1.4.0

## [0.0.9] - 2020-04-15
### Changed
- Bumped duplicacy_web version to 1.3.0

## [0.0.8] - 2020-03-02
### Changed
- Bumped duplicacy_web version to 1.2.1

## [0.0.7] - 2020-02-11
### Changed
- Bumped duplicacy_web version to 1.2.0

## [0.0.6] - 2019-10-28
### Changed
- Bumped duplicacy_web version to 1.1.0

## [0.0.5] - 2019-09-15
### Changed
- Honor TZ environment variable

## [0.0.4] - 2019-01-29
### Changed
- Further simplified machine-id handling. The image now has backed link to externally stored machine-id

## [0.0.3] - 2019-01-29
### Changed
- Optimized machine-id persistence handling.
- Removed option to disable machine-id persistence, it is now always saved to /config
- duplicacy_web wget download log redirected to stdout now.

## [0.0.2] - 2019-01-29
### Fixed
- Generate new machine-id for a new container instance. [credit](https://forum.duplicacy.com/t/run-web-ui-in-a-docker-container/1505/21) 

## [0.0.1] - 2019-01-29
### Added
- Initial public release.
