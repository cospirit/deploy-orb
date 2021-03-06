requirements() {
    if ! which openvpn > /dev/null; then
        echo "OpenVPN is required to connect to VPN"
        exit 1
    fi
    if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi
}

get_ip() {
    ip=$(netstat -an | grep ':22 .*ESTABLISHED' | head -n1 | awk '{ split($5, a, ":"); print a[1] }')
    # if you use macOS executor, you can uncomment this line, and comment the above line
    # ip=$(netstat -an | grep '\.2222\s.*ESTABLISHED' | head -n1 | awk '{ split($5, a, "."); print a[1] "." a[2] "." a[3] "." a[4] }')
    echo "$ip"
}


ovpn_config() {
    printf "%s\n%s" "${VPN_USERNAME}" "${VPN_PASSWORD}" > /tmp/vpn.login
    echo "${VPN_CLIENT_CONFIG}" | base64 -d > /tmp/config.ovpn
}

ovpn_connect() {
    $SUDO openvpn \
        --config /tmp/config.ovpn \
        --auth-user-pass /tmp/vpn.login \
        --route "$1" 255.255.255.255 net_gateway \
        --route 169.254.0.0 255.255.0.0 net_gateway
}

connect() {
    requirements
    ovpn_config
    ovpn_connect "$(get_ip)"
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    connect
fi
