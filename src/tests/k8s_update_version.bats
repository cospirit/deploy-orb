load helpers.sh

setup() {
    source ./src/scripts/k8s_service_version.sh

    export SERVICE_CONF_FILE="${BATS_TMPDIR}/k8s_service_version.yaml"

    cp "./src/tests/fixtures/k8s_service_values.yaml" "${SERVICE_CONF_FILE}"
}

teardown() {
    if [[ -f "${SERVICE_CONF_FILE}" ]]; then rm "${SERVICE_CONF_FILE}"; fi
}

@test 'K8s: Update service version in Helm values succeed' {
    export VERSION="1.1"

    run update_service_version

    [ "$(trim "${lines[3]}")" == 'version: "1.1"' ]
    [ "$(trim "${lines[8]}")" == 'version: "2.0.1"' ]
}

@test 'K8s: Update service Helm values file succeed' {
    export VERSION="1.1"

    run update_service_configuration 10

    [ -f "${SERVICE_CONF_FILE}" ]
    [ "$(trim "${lines[3]}")" == 'version: "1.1"' ]
    [ "$(trim "${lines[8]}")" == 'version: "2.0.1"' ]
}
