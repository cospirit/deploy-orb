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

    echo "$output" >&3

    service_version=$(trim "${lines[2]}")
    sidecar_version=$(trim "${lines[7]}")

    [ "$service_version" == 'version: "1.1"' ]
    [ "$sidecar_version" == 'version: "2.0.1"' ]
}

@test 'K8s: Update service Helm values file succeed' {
    export VERSION="1.1"

    run update_service_configuration

    service_version=$(trim "${lines[2]}")
    sidecar_version=$(trim "${lines[7]}")

    [ -f "${SERVICE_CONF_FILE}" ]
    [ "$service_version" == 'version: "1.1"' ]
    [ "$sidecar_version" == 'version: "2.0.1"' ]
}
