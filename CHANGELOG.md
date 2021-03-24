# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
 - Current development changes [ to be moved to release ]

## [v1.0.3] - 2021-03-24
### Fixed
 - Use correct working directory to build `TAG` environment variable in `git-tag` command. @Spoon4

## [v1.0.2] - 2021-03-15
### Changed
 - Set default value of `create_git_tag` to `false` in `vm` job @Spoon4

### Fixed
- Some typos in esamples @Spoon4

## [v1.0.1] - 2021-03-12
### Changed
 - Set environment variables of `git-tag` command in step's `environment` key instead of using `BASH_ENV` @Spoon4

### Fixed
 - Checkout code in correct directory for git tag creation from `k8s` and `vm` jobs @Spoon4
 - Build GitHub tag in a separated step @Spoon4

## [v1.0] - 2021-03-11
### Added
 - Add unit tests on Helm values files update of `k8s` command @Spoon4
 - Add unit tests on Ansible deployment files update of `vm` job @Spoon4
 - Add unit tests on environement setup of `build-image` command @Spoon4
 - Add helper file with `trim` and `uuid` functions for writing tests convenience @Spoon4

### Changed
 - Change default branch pattern to `release\/v?(([0-9]+\.?){1,3})(\-[a-zA-Z0-9\-\._]*)?` @Spoon4

### Fixed
 - Use `mawk` to replace deployed version in deploy configuration files @Spoon4

## [v0.2.1] - 2020-01-20
### Added
 - Add parameter `checkout` in `git-tag` / `build-image` / `k8s` commands and jobs. This fixes the issue that get git tag creation when not in a git context. @Spoon4
 - Add parameter `lint-dockerfile` in `build-image` command and job. @Spoon4

## [v0.2] - 2020-01-20
### Added
 - Job: `build-image` builds Docker image depending on running environnement. @Spoon4
 - Job: `k8s` deploys to Kubernetes cluster (only AKS is currently supported). @Spoon4
 - Job: `vm` can deploy with Ansible scripts. @Spoon4
 - Command: `build-image` builds Docker image depending on running environnement. @Spoon4
 - Command: `k8s` deploys to Kubernetes cluster (only AKS is currently supported).
 - Add `dvelopment@build` and `dvelopment@cs.lint` make targets. @Spoon4

### Changed
 - Renamed `_vpn` / `-vpn` siffixes with `vpn_` / `vpn-` prefixes in all files. @Spoon4

## [v0.1.3] - 2020-01-18
Initial Release

### Added
 - Orb initialization. @Spoon4
 - Job: `vm` deploys projects on cloud VMs or on premise with VPN connection. @Spoon4
 - Command: `connect-vpn` runs in background to connect to VPN. @Spoon4
 - Command: `disconnect-vpn` disconnects from VPN. This step is always executed. @Spoon4
 - Command: `update-version` updates and push VERSION file of a project if outdated. @Spoon4
 - Command: `git-tag` creates the git tag according to VERSION file. @Spoon4
 - Unit tests. @Spoon4
 - Integration test. @Spoon4
 - Development environment. @Spoon4

### Removed
 - Init Orb example files. @Spoon4


[v1.0.3]: https://github.com/cospirit/deploy-orb/releases/tag/v1.0.3
[v1.0.2]: https://github.com/cospirit/deploy-orb/releases/tag/v1.0.2
[v1.0.1]: https://github.com/cospirit/deploy-orb/releases/tag/v1.0.1
[v1.0]: https://github.com/cospirit/deploy-orb/releases/tag/v1.0
[v0.2.1]: https://github.com/cospirit/deploy-orb/releases/tag/v0.2.1
[v0.2]: https://github.com/cospirit/deploy-orb/releases/tag/v0.2
[v0.1.3]: https://circleci.com/developer/orbs/orb/cospirit/deploy?version=0.1.3
