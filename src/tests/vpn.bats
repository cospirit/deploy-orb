# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/connect_vpn.sh
    source ./src/scripts/disconnect_vpn.sh
    source ./src/scripts/check_ip.sh
    export SUDO=""
    export VPN_CLIENT_CONFIG=$(echo "my OpenVPN configuration file" | base64)
}

@test '1: OpenVPN file created' {
    export VPN_USERNAME=john.doe@email.com
    export VPN_PASSWORD=P4s\$worD
    export VPN_LOGIN_FILE=am9obi5kb2VAZW1haWwuY29tClA0cyR3b3JECg==

    create_ovpn_files

    [ -f /tmp/config.ovpn ]
    [ -f /tmp/vpn.login ]
    [ "${VPN_LOGIN_FILE}" == "$(base64 /tmp/vpn.login)" ]
}

@test '2: openvpn not installed' {
	run requirements
	
	[ "$status" -eq 1 ]
    [ "$output" == "OpenVPN is required to connect to VPN" ]
}
