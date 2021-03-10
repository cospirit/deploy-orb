load helpers.sh

setup() {
    source ./src/scripts/ansible_update_branch.sh

    export VERSION="1.1"
    export BRANCH_PATTERN="release\/v?(([0-9]+\.?){1,3})(\-[a-zA-Z0-9\-\._]*)?"
    export CIRCLE_BRANCH="release/v${VERSION}"
    export DEPLOY_CONF_FILE="${BATS_TMPDIR}/$(uuid).yaml"

    cp "./src/tests/fixtures/ansible_staging_vars.yaml" "${DEPLOY_CONF_FILE}"
}

teardown() {
    if [[ -f "${DEPLOY_CONF_FILE}" ]]; then rm "${DEPLOY_CONF_FILE}"; fi
}

@test 'Ansible: Update deploy branch succeed' {
    run update_deploy_branch

    branch_config="${lines[7]}"

    [ "$branch_config" == "git_branch: \"${CIRCLE_BRANCH}\"" ]
}

@test 'Ansible: Update deployment configuration file succeed' {

    run update_deploy_file

    branch_config="${lines[7]}"

    [[ -f "${DEPLOY_CONF_FILE}" ]]
    [ "$branch_config" == "git_branch: \"${CIRCLE_BRANCH}\"" ]
}

@test 'Ansible: Get message if file is already up to date' {
    export CIRCLE_BRANCH="release/v1.0"
    
    run update_deploy_file

    [ "$status" -eq 0 ]
    [ "$output" == "Branch is already set to ${CIRCLE_BRANCH}" ]
}
