requirements() {
    if ! which openvpn > /dev/null; then
        echo "OpenVPN is required to connect to VPN"
        exit 1
    fi
    if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi
}

ovpn_close() {
    $SUDO killall openvpn || true
}

disconnect() {
    requirements
    ovpn_close
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    disconnect
fi
