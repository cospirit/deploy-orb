# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/connect_vpn.sh
    source ./src/scripts/disconnect_vpn.sh
    source ./src/scripts/check_ip.sh
}

@test '1: OpenVPN file created' {
    # Capture the output of our "disconnect" function
    export VPN_USERNAME=john.doe@email.com
    export VPN_PASSWORD=P4s$worD
    export VPN_LOGIN_FILE=am9obi5kb2VAZW1haWwuY29tClA0cyR3b3JECg==
    create_ovpn_files
    [ -f /tmp/vpn.login ] && [ -f /tmp/config.ovpn ] && [ "${VPN_LOGIN_FILE}" == "$(base64 /tmp/vpn.login)" ]
}

# @test '2: Connect to VPN' {
#     # Capture the output of our "connect" function
#     result=$(connect)
#     sleep 20
#     [ "$result" == "Initialization Sequence Completed" ]
#     # connect
#     # sleep 20
#     # result=$(check_ip)
#     # [ -n "`echo "$result" | grep 10.11.1.1`" ]

# }

# @test '3: Disconnect from VPN' {
#     # Capture the output of our "disconnect" function
#     result=$(disconnect)
#     [ "$result" == "success" ]
# }
