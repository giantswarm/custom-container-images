# Cursor Rules for Custom Container Images Repository

## Project Overview

This is a mono-repository for building custom container images from upstream images. Each folder represents a module for a given upstream image that can contain multiple flavours (variants) of that image.

## Repository Structure

- Each image module has its own directory (e.g., `alpine/`, `mysql/`, `node-exporter/`)
- Dockerfiles are named `<flavour>.dockerfile` (e.g., `default.dockerfile`, `yq.dockerfile`)
- CircleCI configs are in `.circleci/<upstream-image>.yml`
- The `default` flavour is used when there's only one variant

## Development Guidelines

### Adding New Images/Modules

- Use the `add-new-image.sh` script to generate new modules
- Always specify owners, image name, and base image
- Example: `./add-new-image.sh -o "@giantswarm/team-honeybadger" -i "nginx" -b "nginx:1.21.0"`

### Dockerfile Best Practices

- Pin base image versions with specific tags or SHA256 hashes
- Keep Dockerfiles minimal and focused
- Follow security best practices (non-root users, minimal attack surface)

### CircleCI Configuration

- Each workflow must be named `build-<upstream-image>-<flavour>`
- Use the architect orb: `giantswarm/architect@5.8.0` or later
- Required filters for all workflows:
  ```yaml
  filters:
    tags:
      only: "/^<upstream-image>-<flavour>.*/"
    branches:
      ignore: "main"
  ```
- Git tag prefix must match: `<upstream-image>-<flavour>`

### File Naming Conventions

- Dockerfiles: `<module>/<flavour>.dockerfile`
- CircleCI configs: `.circleci/<module>.yml`
- For default flavour: `<module>/default.dockerfile`

### Tagging and Releases

- Tag format: `<upstream-image>-<flavour>/v<semantic-version>`
- For default flavour: `<upstream-image>/v<semantic-version>`
- Always use semantic versioning: `<major>.<minor>.<patch>`
- Tags must be applied to squash merge commits on main branch

### CODEOWNERS Management

- Every new dockerfile must have owners in CODEOWNERS
- CircleCI config files must have owners
- Use team handles like `@giantswarm/team-honeybadger`

## Code Quality Standards

### Dockerfile Standards

- Use multi-stage builds when appropriate
- Minimize layers and image size
- Include health checks where applicable
- Set appropriate USER directive for security
- Use COPY instead of ADD unless specific functionality needed
- Set proper WORKDIR

### YAML Standards (CircleCI)

- Use consistent indentation (2 spaces)
- Keep workflow names descriptive and unique
- Include all required architect parameters
- Validate YAML syntax before committing

### Shell Script Standards

- Use `#!/usr/bin/env bash` shebang
- Include `set -euo pipefail` for safety
- Quote variables properly
- Use meaningful variable names
- Include usage/help functions

## Workflow Guidelines

### Branch Strategy

- Create feature branches for changes
- All branches except `main` are built automatically
- Only squash commits are allowed on merge to main
- Main branch is never built automatically

### Testing

- Test builds happen on all branches except main
- Verify dockerfile syntax and build success
- Check CircleCI configuration validity

### Release Process

1. Make changes in feature branch
2. Create pull request
3. Review and merge (squash commit)
4. Tag the squash commit with proper format
5. CircleCI will build and push the tagged image

## Common Patterns

### Multi-flavour Modules

When a module has multiple flavours (like alpine with yq, envsubst, etc.):
- Each flavour gets its own dockerfile
- Each flavour gets its own workflow in the CircleCI config
- Tag prefixes differentiate the flavours

### Single-flavour Modules

When a module has only one variant:

- Use `default.dockerfile`
- Workflow name: `build-<module>-default`
- Tag format: `<module>/v<version>`

## Security Considerations

- Always pin base image versions
- Scan images for vulnerabilities
- Use minimal base images when possible
- Follow principle of least privilege
- Keep images updated with security patches

## Troubleshooting

### Common Issues

- CircleCI tag regex must be exact format: `"/^<prefix>.*/"` 
- Multiple tags with same prefix may trigger multiple builds
- Avoid pushing multiple tags simultaneously (CircleCI limitation)
- Check CODEOWNERS syntax if ownership issues occur

### Debugging

- Check CircleCI logs for build failures
- Validate dockerfile syntax locally
- Test image builds in local environment
- Verify tag format matches workflow filters

## Tools and Dependencies

- `yq` for YAML manipulation in scripts
- `architect` orb for CircleCI builds
- Docker for local testing
- Git for version control and tagging

## Team Ownership

- Most modules owned by `@giantswarm/team-honeybadger`
- Check CODEOWNERS file for specific ownership
- Update ownership when adding new modules
- Ensure proper team notifications for changes

## Changelog

This repository maintains a changelog at `CHANGELOG.md` in the repository root.

- The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), using **dates** (YYYY-MM-DD) instead of semantic versions
- When making any changes, always add an entry to the changelog under today's date
- Use the categories: `Added`, `Changed`, `Removed`, `Fixed`
- If today's date heading already exists, add entries under it; otherwise create a new date heading at the top
