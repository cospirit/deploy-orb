load helpers.sh

setup_file() {
    export FILE="${BATS_TMPDIR}/$(uuid)"
    cp "./src/tests/fixtures/VERSION" "${FILE}"
}

setup() {
    source ./src/scripts/prepare_docker_build.sh

    export BASH_ENV="${BATS_TMPDIR}/BASH_ENV"
    export BRANCH_PATTERN="release\/v?(([0-9]+\.?){1,3}).*"
}

teardown_file() {
    rm -rf "${BATS_TMPDIR}/BASH_ENV"
}

teardown_file() {
    rm -rf "${FILE}"
}

@test 'Docker build: Env vars for development environment' {
    set_devlopment_vars

    grep -e "VERSION=\"$(cat "${FILE}")\"" "$BASH_ENV"
    grep -e "TAG=\"$(cat "${FILE}")\"" "$BASH_ENV"
}

@test 'Docker build: Env vars for staging environment' {
	export VERSION="$(cat "${FILE}")"
	export CIRCLE_BUILD_NUM=1
	export CIRCLE_BRANCH="release/v${VERSION}"

    set_staging_vars

    grep -e "VERSION=\"${VERSION}\"" "$BASH_ENV"
    grep -e "TAG=\"${VERSION}-build.1\"" "$BASH_ENV"
}

@test 'Docker build: Env vars for production environment' {
    set_production_vars

    grep -e "VERSION=\"$(cat "${FILE}")\"" "$BASH_ENV"
    grep -e "TAG=\"$(cat "${FILE}")\"" "$BASH_ENV"
}

@test 'Docker build: Run for all environments' {
	environments="development staging production"

	for "$env" in "$environments"; do
		export ENV="$env"
	    run set_env

	    [ "$status" -eq 0 ]
	done
	
	export ENV=wrong_env
    run set_env

    [ "$status" -eq 1 ]
    [ "$output" == "Unknown environment ${ENV}" ]
}

@test 'Docker build: Throws an error on unknown environment' {
	export ENV=wrong_env

    run throw_unknown_env

    [ "$status" -eq 1 ]
    [ "$output" == "Unknown environment ${ENV}" ]
}
