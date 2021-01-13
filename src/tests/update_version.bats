# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/update_version.sh
    export BRANCH_PATTERN="release\/v?(([0-9]+\.?){1,3}).*"
	echo "1.0" > VERSION
}

teardown() {
	if [[ -f "VERSION" ]]; then
		rm VERSION
	fi
}

# @test '1: Update VERSION file' {
#     # Mock environment variables or functions by exporting them (after the script has been sourced)
#     export CIRCLE_BRANCH="release/v1.1"
#     # Capture the output of our "update_version" function
#     result=$(update_version)
#     echo $result
#     [ "$result" == "1.1" ]
# }

@test '2: VERSION file is up to date' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export CIRCLE_BRANCH="release/v1.0"
    # Capture the output of our "update_version" function
    result=$(update_version)
    [ "$result" == "VERSION file already up to date" ]
}
