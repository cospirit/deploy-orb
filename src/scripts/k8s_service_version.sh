ORB_TEST_ENV="bats-core"

update_service_version() {
    # replace only first occurence of 'version' configuration 
    # in Helm values to exclude potential sidecars containers
    awk \
        'BEGIN { n=1; FS="\n"; tag=ARGV[2]; ARGV[2]="" } /version:/ { if (n == 1) { n += 1; sub(/version:.*/,"version: \""tag"\""); }} { print $0; } ' \
        "${SERVICE_CONF_FILE}" \
        "${VERSION}"
}

update_service_configuration() {
    config=$(update_service_version)
    echo "$config" > "${SERVICE_CONF_FILE}"
    head -n "$1" "${SERVICE_CONF_FILE}"
}

# Will not run if sourced for bats-core tests.
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    update_service_configuration 3
fi
