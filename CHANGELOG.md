# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


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
