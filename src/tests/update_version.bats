load helpers.sh

setup() {
    source ./src/scripts/update_version.sh

    export BRANCH_PATTERN="release\/v?(([0-9]+\.?){1,3}).*"
    export FILE="${BATS_TMPDIR}/$(uuid)"

    cp "./src/tests/fixtures/VERSION" "${FILE}"
}

teardown() {
    if [[ -f "${FILE}" ]]; then rm "${FILE}"; fi
}

@test 'Version: File update succeed' {
    export CIRCLE_BRANCH="release/v1.1"
    export VERSION=$(echo "${CIRCLE_BRANCH}" | sed -E "s/${BRANCH_PATTERN}/\\1/")
    
    result=$(update_version)

    [ "$result" == "1.1" ]
}

@test 'Version: Get message if file is already up to date' {
    export CIRCLE_BRANCH="release/v1.0"
    export VERSION=$(echo "${CIRCLE_BRANCH}" | sed -E "s/${BRANCH_PATTERN}/\\1/")
    
    run update_version
    
    [ "$status" -eq 0 ]
    [ "$output" == "${FILE} file is already up to date" ]
}
