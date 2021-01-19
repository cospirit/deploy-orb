# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
 - Current development changes [ to be moved to release ]

## [v0.2] - 2020-01-20
### Added
 - Job: `build-image` builds Docker image depending on running environnement.
 - Job: `k8s` deploys to Kubernetes cluster (only AKS is currently supported).
 - Job: `vm` can deploy with Ansible scripts
 - Job: Add `pre-deploy` and `post-deploy` parameters on `vm` job to add custom steps.
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


[v0.1.3]: https://circleci.com/developer/orbs/orb/cospirit/deploy?version=0.1.3
[v0.2]: https://github.com/cospirit/deploy-orb/releases/tag/v0.2
