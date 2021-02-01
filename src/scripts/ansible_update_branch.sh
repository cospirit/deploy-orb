update_deploy_branch() {
    # replace only first occurence of 'git_branch' configuration in ansible file
    awk \
        'BEGIN { n=1; FS="\n"; branch=ARGV[2]; ARGV[2]="" } /git_branch:/ { if (n == 1) { n += 1; sub(/.*/,"git_branch: \""branch"\""); }} { print $0; } ' \
        "${DEPLOY_CONF_FILE}" \
        "${CIRCLE_BRANCH}"
}

update_deploy_file() {
    if [ "$(grep -oE "${BRANCH_PATTERN}" "${DEPLOY_CONF_FILE}")" != "${CIRCLE_BRANCH}" ]; then
        config=$(update_deploy_branch)
        echo "$config" > "${DEPLOY_CONF_FILE}"
        head -n 11 "${DEPLOY_CONF_FILE}"
    else
        echo "Branch is already set to ${CIRCLE_BRANCH}"
    fi
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    update_deploy_file
fi
