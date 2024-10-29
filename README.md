# Custom image build mono repository

This is a mono repository designed to build custom container images from upstream images.

Each folder within the repository is a module for a given upstream image that can contain multiple flavours of that image.

When there are no flavours for the image, thus there is simply only one, then that is called the default flavour.

For each image flavour there must be a Dockerfile located at: `<upstream-image>/<flavour>.dockerfile`.
Each container image build will be done by `architect` and the `<upstream-image>` folder will be used as context.

For each `<upstream-image>` there must be a CircleCI config located at: `.circleci/<upstream-image>.yml`.

Within that file, for each flavour there must be a workflow defined under `.workflows`. The name of the workflow must
be unique within the whole repository, so we recommend following the convention: `build-<upstream-image>-<flavour>`.

Each workflow should be an `architect` build. They all need the following filters to work correctly with the pipeline:

```yaml
filters:
  tags:
    only: "/^<upstream-image>-<flavour>.*/"
  branches:
    ignore: "main"
```

Finally, we would like to associate owners for each custom image. We need `<upstream-image>/<flavour>.dockerfile` in
the `CODEOWNERS` file and the owners listed or added for `.circleci/<upstream-image>.yml`. Also, if additional files are
added under `<upstream-image>` folder and used in the build context, those need an owner too.

## Summary

We want a custom image for `nginx`:

- We need `nginx/default.dockerfile`
- We need `.circleci/nginx.yml`
  - In this file, we need `.workflows.build-nginx-default` to contain an `architect` build
  - We need the above filter for each workflow to work correctly with the root pipeline

## How to add new modules and flavours

You can use the `add-new-image.sh` script to generate new modules. For example:

```shell
./add-new-image.sh -o "@giantswarm/team-honeybadger" -i "kratix" -f "yq" -b "gsoci.azurecr.io/giantswarm/kratix-base-cli:0.1.0"
```

# How to work with this repository?

In order to add new module(s), flavour(s) or change existing ones, please open a branch and a pull request.

All branches are built except `main`. Only the modules (not limited down to flavours) that contain a change will be built on these branches.

The repository is configured to only allow squash commits on merge.

The `main` branch never gets built. If you want to release the modified flavour you have to **manually** tag the squash
commit that contains the change compared to the previous commit.

You must comply with the following tagging convention.

## How to tag commit to release an image

The commit must be done on the squash merge commit that contains the change and follow the convention:
`<upstream-image>-<flavour>/v<semantic-version>`.

The semantic version must always contain `<major>.<minor>.<patch>` versions, even if the upstream image does not.
It makes sense to follow upstream with the custom image tags, but they are GS custom images after all, and this is
the versioning that we follow and support in our tooling.

For the above `nginx` example to release `1.2.3` it must be: `nginx/v1.2.3`. So for `default` flavour you can omit
the flavour.

For example, for a flavour of `gs`, it should be `nginx-gs/v1.2.3`.

The reality is that it must match the `git-tag-prefix` field in the workflow.

# Here be dragons

The core of the build is `.circleci/config.yaml`. It uses the `bjd2385/dynamic-continuation` orb to conduct the build
by figuring out which modules needs to be built. For docs, see: https://github.com/emmeowzing/dynamic-continuation-orb.

It is a handy plugin, but it solely focuses on changes, and it does not work correctly with tags.

Therefor we have 2 jobs defined for it:

- One runs only on tags, all of them and ignores branch changes
  - In this job we set `force-all: true` to potentially trigger the build for all modules, see below. 
- The other one runs on all branches except `main`, but not tags (because it is omitted)
  - In this job, the changes are discovered by the plugin and the relevant builds will be triggered separately and
    in parallel to each other.

Each module should have this filter for their jobs:

```yaml
filters:
  tags:
    only: "/^<upstream-image>-<flavour>.*/"
  branches:
    ignore: "main"
```

This makes it possible that they only run on the proper tag or an all branches but not `main`. So the `tags.only`
part will handle the spawned child build from the continuation of a tag triggered workflow where we set the
`force-all: true` field. So even tho all modules are triggered, the ones not matching the tag will skip building their
jobs if they have this on them. The `branches.ignore` one makes it possible to run on branches and thus creating test
artifacts normal to `architect` on pull requests.

## CircleCI limitations

### Tag regex format

Please note that the `filters.tags.only` must be in this format: `"/^<upstream-image>-<flavour>.*/"`. No more, no less!
Because of bugs in CircleCI, if you for example omit the starting `/` or ending `/`, or you include the `/` after
the flavour that is normally part of the tag, it will not parse the regex correctly and will skip the job. Not even escaping
the `/` withing the regex under any combiation got it working. The docs claim that `java.util.regex.Pattern` is used,
but I believe there is some wrong mangling on the string that is passed down and some corner cases are not working correctly.

In case you have multiple tags stating with the same prefix, e.g. `nginx` and `nginx-gs`, then the `nginx-gs` tag
will trigger the `nginx` one too because the regex will match it. But `architect` will handle it correctly. It is simply
that we end up with a useless artifact, but oh well.

### Tag pushing limitations

According to CircleCI doc: https://circleci.com/docs/workflows/#executing-workflows-for-a-git-tag there can be
circumstances of not triggering a build for each pushed tags if too many tags are pushed at the same time.

The document mentions 3, so please try to push tags separately and possibly with small delay if multiple custom images
are changes at the same time. ¯\\\_(ツ)_/¯
