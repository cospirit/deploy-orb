setup() {
    source ./src/scripts/update_version.sh

    export BRANCH_PATTERN="release\/v?(([0-9]+\.?){1,3}).*"
    export FILE="VERSION"

	echo "1.0" > "${FILE}"
}

teardown() {
	if [[ -f "${FILE}" ]]; then rm "${FILE}"; fi
}

@test '1: VERSION file update succeed' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export CIRCLE_BRANCH="release/v1.1"
    export VERSION=$(echo "${CIRCLE_BRANCH}" | sed -E "s/${BRANCH_PATTERN}/\\1/")
    # Capture the output of "update_version" function
    result=$(update_version)
    [ "$result" == "1.1" ]
}

@test '2: VERSION file is up to date' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export CIRCLE_BRANCH="release/v1.0"
    export VERSION=$(echo "${CIRCLE_BRANCH}" | sed -E "s/${BRANCH_PATTERN}/\\1/")
    # Capture the output of "update_version" function
    result=$(update_version)
    [ "$result" == "${FILE} file already up to date" ]
}
