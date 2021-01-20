set_devlopment_vars(){
    version="$(cat "${FILE}")"
    echo "export VERSION=\"$version\"" >> "$BASH_ENV"
    echo "export TAG=\"$version\"" >> "$BASH_ENV"
}

set_staging_vars() {
    version=$(echo "${CIRCLE_BRANCH}" | sed -E "s/${BRANCH_PATTERN}/\\1/")
    echo "export VERSION=\"$version\"" >> "$BASH_ENV"
    echo "export TAG=\"${version}-build.${CIRCLE_BUILD_NUM}\"" >> "$BASH_ENV"
}

set_production_vars() {
    version="$(cat "${FILE}")"
    echo "export VERSION=\"$version\"" >> "$BASH_ENV"
    echo "export TAG=\"$version\"" >> "$BASH_ENV"
}

extract_version_from_branch() {
    echo "${CIRCLE_BRANCH}" | sed -E "s/$1/\\1/"
}

throw_unknown_env() {
    echo "Unknown environment ${ENV}"
    exit 1
}

set_env() {
    case "${ENV}" in
        development) set_devlopment_vars;;
        staging) set_staging_vars;;
        production) set_production_vars;;
        *) throw_unknown_env;;
    esac
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    set_env
fi
