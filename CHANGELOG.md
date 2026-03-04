# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
We use dates instead of semantic versions.

## 2026-02-07

### Added

- `claude-code-ci` image based on `node:24-alpine` with Claude Code, dev tools (git, gh, jq, ripgrep, fd, bat, etc.), and Python tools (uv, tldr)
- `claude-code-ci` custom entrypoint with CI defaults: `--print`, `--allow-dangerously-skip-permissions`, `--model claude-haiku-4-5-20251001`, `--max-turns 10`, `--max-budget-usd 0.20`, `--verbose`; all overridable via env vars

## 2025-12-08

### Changed

- `apache2-utils`: added arm64 architecture for use in mc-bootstrap on ARM

## 2025-10-07

### Added

- `yamllint` image based on Python 3.13 Alpine
- `alpine-bats` image for giantswarm/helmclient integration tests

## 2025-08-28

### Changed

- Switched base image registry from quay.io to gsoci.azurecr.io

## 2025-03-04

### Added

- `apache2-utils` image

## 2024-10-29

### Changed

- Updated base image for `calico-crd-installer`
- Corrected pipelines for `awscli-tar` and `calico-crd-installer`
- Updated images to the latest versions done by retagger
- Bumped `dynamic-continuation` orb to v3.9.1

## 2024-10-04

### Changed

- Updated `alpine/envsubst` Dockerfile
