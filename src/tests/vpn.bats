# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/check_ip.sh
    source ./src/scripts/connect_vpn.sh
    source ./src/scripts/disconnect_vpn.sh
    export SUDO=""
    export VPN_CLIENT_CONFIG=$(echo "my OpenVPN configuration file" | base64)
}

@test '1: OpenVPN configuration files creation success' {
    export VPN_USERNAME=john.doe@email.com
    export VPN_PASSWORD=P4s\$worD
    export VPN_CLIENT_CONFIG_ENCODED=bXkgT3BlblZQTiBjb25maWd1cmF0aW9uIGZpbGUK

    ovpn_config

    [ -f /tmp/config.ovpn ]
    [ -f /tmp/vpn.login ]
    [ "${VPN_CLIENT_CONFIG_ENCODED}" == "$(base64 /tmp/config.ovpn)" ]
}

@test '2: Fail if OpenVPN is not installed' {
	run requirements
	
	[ "$status" -eq 1 ]
    [ "$output" == "OpenVPN is required to connect to VPN" ]
}
