create_tag() {
    git config --global user.email "${GIT_USER_EMAIL}"
    git config --global user.name "${GIT_USER_NAME}"
    git tag "${TAG}"
    git push --tag origin
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    create_tag
fi
