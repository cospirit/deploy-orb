setup() {
    source ./src/scripts/k8s_service_version.sh

    fixture="${BATS_TMPDIR}/k8s_service_version.yaml"
    cp "./src/tests/fixtures/k8s_service_values.yaml" "$fixture"

    export SERVICE_CONF_FILE="$fixture"
}

teardown() {
    if [[ -f "${SERVICE_CONF_FILE}" ]]; then rm "${SERVICE_CONF_FILE}"; fi
}

@test '> K8s service version update succeed' {
    export VERSION="1.1"

    run update_service_version

    service_version=${lines[2]#"${lines[2]%%[![:space:]]*}"}
    sidecar_version=${lines[7]#"${lines[7]%%[![:space:]]*}"}

    [ "$service_version" == 'version: "1.1"' ]
    [ "$sidecar_version" == 'version: "2.0.1"' ]
}

@test '> K8s service configuration file update succeed' {
    export VERSION="1.1"

    run update_service_configuration

    service_version=${lines[2]#"${lines[2]%%[![:space:]]*}"}
    sidecar_version=${lines[7]#"${lines[7]%%[![:space:]]*}"}

    [ -f "${SERVICE_CONF_FILE}" ]
    [ "$service_version" == 'version: "1.1"' ]
    [ "$sidecar_version" == 'version: "2.0.1"' ]
}
