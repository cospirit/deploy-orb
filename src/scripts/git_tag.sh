create_tag() {
	git config --global user.email ${GITHUB_USER_EMAIL}
	git config --global user.name ${GITHUB_USER_NAME}
	git tag ${TAG}
	git push --tag origin
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    create_tag
fi
