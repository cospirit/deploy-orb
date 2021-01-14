![CoSpirit](doc/logo.png)

# CircleCi Orb - cospirit/deploy

[![CircleCI Build Status](https://circleci.com/gh/cospirit/deploy-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/cospirit/deploy-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/cospirit/deploy)](https://circleci.com/orbs/registry/orb/cospirit/deploy) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/cospirit/deploy-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)



Main orb used to deploy CoSpirit applications. 
Build, test, and publish orbs automatically on CircleCI with [Orb-Tools](https://circleci.com/orbs/registry/orb/circleci/orb-tools).

# Orb Development Pipeline

This configuration file uses [orb-tools orb]() version 10 to automatically _pack_, _test_, and _publish_ CircleCI orbs using this project structure. View the comments within the config file for a full break  down

## Overview:

**Imported Orbs**

Both orb-tools and a development version of your orb will be imported into the config. On the first run, a `dev:alpha` development tag _must_ exist on your orb, but will be handled automatically from there on.

**Jobs**

In the _jobs_ key, you will define _integration tests_. These jobs will utilize the functionality of your orb at run-time and attempt to validate their usage with live examples. Integration tests can be an excellent way of determining issues with parameters and run-time execution.

### Workflows

There are two workflows which automate the pack, test, and publishing process.

**test-pack**

This is the first of the two workflows run. This workflow is responsible for any testing or prepping prior to integration tests. This is where linting occurs, shellchecking, BATS tests, or anything else that can be be tested without the need for further credentials.

This Workflow will be placed on _hold_ prior to publishing a new development version of the orb (based on this commit), as this step requires access to specific publishing credentials.

This allows users to fork the orb repository and begin the pipeline, while the code-owners review that the code is safe to test in an environment where publishing keys will be present.

Once approved, the development version of the orb will publish and the _trigger-integration-tests-workflow_ job will run, kicking off the next workflow

**integration-test_deploy**

The second and final workflow is manually triggered by the _trigger-integration-tests-workflow_ job. In this run, the development version of the orb that was just published will be imported, and the integration tests will run.

When running on the `master` branch (after merging to `master`), the workflow will additionally publish your new production orb.

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/cospirit/deploy-orb) - The official registry page of this orb for all versions, executors, commands, and jobs described.
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.

### How to Contribute

We welcome [issues](https://github.com/cospirit/deploy-orb/issues) to and [pull requests](https://github.com/cospirit/deploy-orb/pulls) against this repository!

### How to Publish
* Create and push a branch with your new features.
* When ready to publish a new production version, create a Pull Request from _feature branch_ to `master`.
* The title of the pull request must contain a special semver tag: `[semver:<segement>]` where `<segment>` is replaced by one of the following values.

| Increment | Description|
| ----------| -----------|
| major     | Issue a 1.0.0 incremented release|
| minor     | Issue a x.1.0 incremented release|
| patch     | Issue a x.x.1 incremented release|
| skip      | Do not issue a release|

Example: `[semver:major]`

* Squash and merge. Ensure the semver tag is preserved and entered as a part of the commit message.
* On merge, after manual approval, the orb will automatically be published to the Orb Registry.


For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).

## Executors

Easily author and add [Parameterized Executors](https://circleci.com/docs/2.0/reusing-config/#executors) to the `src/executors` directory.

Each _YAML_ file within this directory will be treated as an orb executor, with a name which matches its filename.

Executors can be used to parameterize the same environment across many jobs. Orbs nor jobs _require_ executors, but may be helpful in some cases, such as: [parameterizing the Node version for a testing job so that matrix testing may be used](https://circleci.com/orbs/registry/orb/circleci/node#usage-run_matrix_testing).

View the included _[hello.yml](./hello.yml)_ example.


```yaml
description: >
  This is a sample executor using Docker and Node.
docker:
  - image: 'cimg/node:<<parameters.tag>>'
parameters:
  tag:
    default: lts
    description: >
      Pick a specific circleci/node image variant:
      https://hub.docker.com/r/cimg/node/tags
    type: string
```

### See:
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [How To Author Executors](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-executors)
 - [Node Orb Executor](https://github.com/CircleCI-Public/node-orb/blob/master/src/executors/default.yml)

## Jobs

Easily author and add [Parameterized Jobs](https://circleci.com/docs/2.0/reusing-config/#authoring-parameterized-jobs) to the `src/jobs` directory.

Each _YAML_ file within this directory will be treated as an orb job, with a name which matches its filename.

Jobs may invoke orb commands and other steps to fully automate tasks with minimal user configuration.

View the included _[hello.yml](./hello.yml)_ example.


```yaml
  # What will this job do?
  # Descriptions should be short, simple, and clear.
  Sample description
executor: default
parameters:
  greeting:
    type: string
    default: "Hello"
    description: "Select a proper greeting"
steps:
  - greet:
      greeting: << parameters.greeting >>
```

### See:
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [How To Author Commands](https://circleci.com/docs/2.0/reusing-config/#authoring-parameterized-jobs)
 - [Node Orb "test" Job](https://github.com/CircleCI-Public/node-orb/blob/master/src/jobs/test.yml)

## Commands

Easily add and author [Reusable Commands](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-commands) to the `src/commands` directory.

Each _YAML_ file within this directory will be treated as an orb command, with a name which matches its filename.

View the included _[greet.yml](./greet.yml)_ example.

```yaml
description: >
  Replace this text with a description for this command.
  # What will this command do?
  # Descriptions should be short, simple, and clear.
parameters:
  greeting:
    type: string
    default: "Hello"
    description: "Select a proper greeting"
steps:
  - run:
      name: Hello World
      command: echo << parameters.greeting >> world
```

### See:
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [How to author commands](https://circleci.com/docs/2.0/reusing-config/#authoring-reusable-commands)

## scripts/

This is where any scripts you wish to include in your orb can be kept. This is encouraged to ensure your orb can have all aspects tested, and is easier to author, since we sacrifice most features an editor offers when editing scripts as text in YAML.

As a part of keeping things seperate, it is encouraged to use environment variables to pass through parameters, rather than using the `<< parameter. >>` syntax that CircleCI offers.

## tests/

This is where your testing scripts for whichever language is embeded in your orb live, which can be executed locally and within a CircleCI pipeline prior to publishing.

## Including Scripts

Utilizing the `circleci orb pack` CLI command, it is possible to import files (such as _shell scripts_), using the `<<include(scripts/script_name.sh)>>` syntax in place of any config key's value.

```yaml
# commands/greet.yml
description: >
  This command echos "Hello World" using file inclusion.
parameters:
  to:
    type: string
    default: "World"
    description: "Hello to who?"
steps:
  - run:
      environment:
        PARAM_TO: <<parameters.to>
      name: Hello <<parameters.to>
      command: <<include(scripts/greet.sh)>>

```

```shell
# scripts/greet.sh
Greet() {
    echo Hello ${PARAM_TO}
}

# Will not run if sourced from another script. This is done so this script may be tested.
# View src/tests for more information.
if [[ "$_" == "$0" ]]; then
    Greet
fi
```

## Testing Orbs

This orb is built using the `circleci orb pack` command, which allows the _command_ logic to be separated out into separate _shell script_ `.sh` files. Because the logic now sits in a known and executable language, it is possible to perform true unit testing using existing frameworks such a [BATS-Core](https://github.com/bats-core/bats-core#installing-bats-from-source).

#### **Example _command.yml_**

```yaml

description: A sample command

parameters:
  source:
    description: "source path parameter example"
    type: string
    default: src

steps:
  - run:
      name: "Ensure destination path"
      environment:
        ORB_SOURCE_PATH: <<parameters.source>>
      command: <<include(scripts/command.sh)>>
```
<!--- <span> is used to disable the automatic linking to a potential website. --->
#### **Example _command<span>.sh_**

```bash

CreatePackage() {
    cd "$ORB_SOURCE_PATH" && make
    # Build some application at the source location
    # In this example, let's assume given some
    # sample application and known inputs,
    # we expect a certain logfile would be generated.
}

# Will not run if sourced from another script.
# This is done so this script may be tested.
if [[ "$_" == "$0" ]]; then
    CreatePackage
fi

```

We want our script to execute when running in our CI environment or locally, but we don't want to execute our script if we are testing it. In the case of testing, we only want to source the functions within our script,t his allows us to mock inputs and test individual functions.

**A POSIX Compliant Source Checking Method:**

```shell
# Will not run if sourced for bats.
# View src/tests for more information.
TEST_ENV="bats-core"
if [ "${0#*$TEST_ENV}" == "$0" ]; then
    RUN CODE
fi
```

**Example _command_tests.bats_**

BATS-Core is a useful testing framework for shell scripts. Using the "source checking" methods above, we can source our shell scripts from within our BATS tests without executing any code. This allows us to call specific functions and test their output.

```bash
# Runs prior to every test.
setup() {
    # Load functions from our script file.
    # Ensure the script will not execute as
    # shown in the above script example.
    source ./src/scripts/command.sh
}

@test '1: Test Build Results' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export ORB_SOURCE_PATH="src/my-sample-app"
    CreatePackage
    # test the results
    grep -e 'RESULT="success"' log.txt
}

```

Tests can contain any valid shell code. Any error codes returned during a test will result in a test failure.

In this example, we grep the contents of `log.txt.` which should contain a `success` result if the `CreatePackage` function we had loaded executed successfully.

### See:
 - [BATS Orb](https://circleci.com/orbs/registry/orb/circleci/bats)
 - [Orb Testing CircleCI Docs](https://circleci.com/docs/2.0/testing-orbs)
 - [BATS-Core GitHub](https://github.com/bats-core/bats-core)


## Usage Examples

Easily author and add [Usage Examples](https://circleci.com/docs/2.0/orb-author/#providing-usage-examples-of-orbs) to the `src/examples` directory.

Each _YAML_ file within this directory will be treated as an orb usage example, with a name which matches its filename.

View the included _[example.yml](./example.yml)_ example.

Usage examples should contain clear use-case based example configurations for using the orb.


### See:
 - [Providing Usage examples](https://circleci.com/docs/2.0/orb-author/#providing-usage-examples-of-orbs)