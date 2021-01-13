requirements() {
	if ! which openvpn > /dev/null; then
		echo "OpenVPN is required to connect to VPN"
		exit 1
	fi
	if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi
}

close_connection() {
	$SUDO killall openvpn || true
}

disconnect() {
	requirements
	close_connection
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    disconnect
fi
