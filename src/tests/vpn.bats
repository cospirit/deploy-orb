setup() {
    # Because all scripts have 'requirements' function,
    # they will override each together.
    # So it's important that the tested one was sourced last.
    source ./src/scripts/check_ip.sh
    source ./src/scripts/vpn_connect.sh
    source ./src/scripts/vpn_disconnect.sh

    export SUDO=""
    export VPN_CLIENT_CONFIG=$(echo "My decoded OpenVPN configuration file content." | base64)
}

@test '> OpenVPN configuration files creation success' {
    export VPN_USERNAME=john.doe@email.com
    export VPN_PASSWORD=P4s\$worD
    vpn_client_config_encoded=TXkgZGVjb2RlZCBPcGVuVlBOIGNvbmZpZ3VyYXRpb24gZmlsZSBjb250ZW50Lgo=
    vpn_client_login_file=$(printf "%s\n%s" "${VPN_USERNAME}" "${VPN_PASSWORD}")

    ovpn_config

    [ -f /tmp/config.ovpn ]
    [ -f /tmp/vpn.login ]
    [ "$vpn_client_config_encoded" == "$(base64 /tmp/config.ovpn)" ]
    [ "$vpn_client_login_file" == "$(cat /tmp/vpn.login)" ]
}

@test '> Fail if OpenVPN is not installed' {
    run requirements

    [ "$status" -eq 1 ]
    [ "$output" == "OpenVPN is required to connect to VPN" ]
}
