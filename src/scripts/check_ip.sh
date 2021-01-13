
check_ip() {
	ifconfig
    route -n
    sudo netstat -anp
    cat /etc/resolv.conf
    curl checkip.amazonaws.com
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    check_ip
fi
