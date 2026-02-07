# claude-code-ci

Claude Code for use in CI/CD pipelines.

## TODO

- Add GitHub PR details

## Defaults

The entrypoint always applies `--print` and `--allow-dangerously-skip-permissions`. All other defaults are configurable via environment variables.

## Environment variables

Use these environment variables to configure the execution of `claude`.

| Variable | Default | CLI flag | Description |
|----------|---------|----------|-------------|
| `CLAUDE_MODEL` | `claude-haiku-4-5-20251001` | `--model` | Model to use |
| `CLAUDE_MAX_TURNS` | `10` | `--max-turns` | Maximum agentic turns |
| `CLAUDE_MAX_BUDGET` | `0.20` | `--max-budget-usd` | Maximum spend in USD |
| `CLAUDE_VERBOSE` | `1` | `--verbose` | Verbose logging (`1` = on, `0` = off) |
| `CLAUDE_OUTPUT_FORMAT` | `json` | `--output-format` | Output format (`text`, `json`, `stream-json`) |

Any additional arguments passed to the container are forwarded directly to `claude`.

## Testing

`$TAG` must be an existing tag.

```bash
# With defaults
docker run \
    gsoci.azurecr.io/giantswarm/claude-code-ci:$TAG \
    "explain this code"

# With overrides
docker run \
    -e CLAUDE_MODEL=sonnet \
    -e CLAUDE_MAX_BUDGET=1.00 \
    gsoci.azurecr.io/giantswarm/claude-code-ci:$TAG \
    "review this PR"

# Pass extra flags
docker run \
    gsoci.azurecr.io/giantswarm/claude-code-ci:$TAG \
    --output-format json \
    "summarize this repo"
```

## Usage in a GitHub workflow

Here is an example.

```yaml
name: Auto-update changelog

on:
  pull_request: {}

permissions: {}

jobs:
  report:
    runs-on: ubuntu-latest
    permissions:
      contents: write # To push commits
      pull-requests: write # To comment in PR
    steps:
      - name: Checkout
        uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
        with:
          fetch-depth: 0 # We need the full history to compare changes
          persist-credentials: true # For the next step

      - name: Update changelog
        uses: docker://gsoci.azurecr.io/giantswarm/claude-code:v0.0.1
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          args: >
            "You are executed in a Github action runner, in the context of a pull request.
            Environment variables give you information about the repository etc.
            You have the gh CLI available.

            Your task: If a CHANGELOG.md file exists in the repository root, check if the current pull
            request updates it.

            If CHANGELOG.md exists, but is not updated in this PR, update it with information
            about the changes in this branch compared to the default branch. Push a simple commit
            to the PR's branch. Do not rebase.

            Normally, dependency updates fall under the '### Changed' category. In some cases,
            if they are security-related, they might fall under the '### Fixed' category.
            
            Use the pull request title and description for hints. Use `git diff` to find out details about file changes.

            Do nothing else. Do not recommend next actions. Finish the given task in one step.
            
            ---------------------------------
            Pull request details:

            - **Title:** '${{ github.event.pull_request.title }}'
            - **Author:** '${{ github.event.pull_request.user.login }}' (${{ github.event.pull_request.user.name }})
            - **Branch:** '${{ github.head_ref }}'
            - **Base branch:** ${{ github.event.pull_request.base.ref }}
            - **Repository:** ${{ github.repository }}
            - **PR number:** ${{ github.event.pull_request.number }}

            **Description:**
            
            ${{ github.event.pull_request.body }}

            **Changed files:**
            
            ${{ join(github.event.pull_request.changed_files, ', ') }}
            
            ---------------------------------"
```