update_service_version() {
	sed -i "0,/version:.*$/ s/version:.*$/version: ${VERSION}/" "${K8S_CONF_FILE}"
    head -n 3 "${K8S_CONF_FILE}"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    update_service_version
fi
