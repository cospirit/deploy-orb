ORB_TEST_ENV="bats-core"

update_version() {
    if [ -n "${VERSION}" ] && [ "${VERSION}" != "$(cat "${FILE}")" ]; then
        echo "${VERSION}" > "${FILE}"
        if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
            git config --global user.email "${GIT_USER_EMAIL}"
            git config --global user.name "${GIT_USER_NAME}"
            git commit -m "chore(version): ${VERSION} [skip ci]" "${FILE}"
            git push origin "${CIRCLE_BRANCH}"
        fi
        cat "${FILE}"
    else
      echo "${FILE} file already up to date"
    fi
}

# Will not run if sourced for bats-core tests.
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    update_version
fi
