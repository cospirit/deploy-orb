ORB_TEST_ENV="bats-core"

update_version() {
	echo "export VERSION=$(echo "$CIRCLE_BRANCH" | sed -E \'s/"$BRANCH_PATTERN"/\\1/\')" >> "$BASH_ENV"
	if [ -n "${VERSION}" ] && [ "${VERSION}" != "$(cat VERSION)" ]; then
	  	echo "${VERSION}" > "${FILE}"
	  	if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
			git config --global user.email "${GIT_USER_EMAIL}"
		  	git config --global user.name "${GIT_USER_NAME}"
		  	git commit -m "chore(version): ${VERSION} [skip ci]" VERSION
		  	git push origin "${CIRCLE_BRANCH}"
		fi
	  	cat VERSION
	else
	  echo "VERSION file already up to date"
	fi
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
	update_version
fi
