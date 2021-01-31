ORB_TEST_ENV="bats-core"

if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
	head_line_count=3
else
    head_line_count=10
fi

update_service_version() {
    awk \
        'BEGIN { n=1; FS="\n" } /version:/ { if (n == 1) { n += 1; sub(/".*"/,"\""'"${VERSION}"'"\""); }} { print $0; } ' \
        "${SERVICE_CONF_FILE}"
}

update_service_configuration() {
    config=$(update_service_version)
    echo "$config" > "${SERVICE_CONF_FILE}"
    head -n "$head_line_count" "${SERVICE_CONF_FILE}"
}

# Will not run if sourced for bats-core tests.
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    update_service_configuration
fi
