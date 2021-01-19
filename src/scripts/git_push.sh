git_push() {
	git config --global user.email "${GIT_USER_EMAIL}"
    git config --global user.name "${GIT_USER_NAME}"
    git pull origin "$3"
    git commit -m "$1 [skip ci]" "$2"
    git push "$3"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    git_push "${COMMIT_MSG}" "${COMMIT_FILE}" "${COMMIT_BRANCH:-master}"
fi
