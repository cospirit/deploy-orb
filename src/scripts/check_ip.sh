requirements() {
    if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi
}

check_ip() {
    requirements

    ifconfig
    route -n
    $SUDO netstat -anp
    cat /etc/resolv.conf
    curl checkip.amazonaws.com
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    check_ip
fi
