# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
 - Current development changes [ to be moved to release ]

## [v1.0.1] - 2021-03-12
### Changed
 - Set environment variables of `git-tag` command in step's `environment` key instead of using `BASH_ENV`

### Fixed
 - Checkout code in correct directory for git tag creation from `k8s` and `vm` jobs
 - Build GitHub tag in a separated step

## [v1.0] - 2021-03-11
### Added
 - Add unit tests on Helm values files update of `k8s` command
 - Add unit tests on Ansible deployment files update of `vm` job
 - Add unit tests on environement setup of `build-image` command
 - Add helper file with `trim` and `uuid` functions for writing tests convenience

### Changed
 - Change default branch pattern to `release\/v?(([0-9]+\.?){1,3})(\-[a-zA-Z0-9\-\._]*)?`

### Fixed
 - Use `mawk` to replace deployed version in deploy configuration files

## [v0.2.1] - 2020-01-20
### Added
 - Add parameter `checkout` in `git-tag` / `build-image` / `k8s` commands and jobs. This fixes the issue that get git tag creation when not in a git context.
 - Add parameter `lint-dockerfile` in `build-image` command and job.

## [v0.2] - 2020-01-20
### Added
 - Job: `build-image` builds Docker image depending on running environnement.
 - Job: `k8s` deploys to Kubernetes cluster (only AKS is currently supported).
 - Job: `vm` can deploy with Ansible scripts
 - Command: `build-image` builds Docker image depending on running environnement.
 - Command: `k8s` deploys to Kubernetes cluster (only AKS is currently supported).
 - Add `dvelopment@build` and `dvelopment@cs.lint` make targets

### Changed
 - Renamed `_vpn` / `-vpn` siffixes with `vpn_` / `vpn-` prefixes in all files

## [v0.1.3] - 2020-01-18
Initial Release

### Added
 - Orb initialization
 - Job: `vm` deploys projects on cloud VMs or on premise with VPN connection
 - Command: `connect-vpn` runs in background to connect to VPN
 - Command: `disconnect-vpn` disconnects from VPN. This step is always executed.
 - Command: `update-version` updates and push VERSION file of a project if outdated
 - Command: `git-tag` creates the git tag according to VERSION file
 - Unit tests
 - Integration test
 - Development environment

### Removed
 - Init Orb example files


[v1.0.1]: https://github.com/cospirit/deploy-orb/releases/tag/v1.0.1
[v1.0]: https://github.com/cospirit/deploy-orb/releases/tag/v1.0
[v0.2.1]: https://github.com/cospirit/deploy-orb/releases/tag/v0.2.1
[v0.2]: https://github.com/cospirit/deploy-orb/releases/tag/v0.2
[v0.1.3]: https://circleci.com/developer/orbs/orb/cospirit/deploy?version=0.1.3
