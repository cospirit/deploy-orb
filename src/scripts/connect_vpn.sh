get_ip() {
	ip=$(netstat -an | grep ':22 .*ESTABLISHED' | head -n1 | awk '{ split($5, a, ":"); print a[1] }')
	# if you use macOS executor, you can uncomment this line, and comment the above line
	# ip=$(netstat -an | grep '\.2222\s.*ESTABLISHED' | head -n1 | awk '{ split($5, a, "."); print a[1] "." a[2] "." a[3] "." a[4] }')
	echo "$ip"
}


create_ovpn_files() {
	echo "${VPN_CONFIG}" | base64 --decode > /tmp/config.ovpn
	echo -e "${VPN_USERNAME}\n${VPN_PASSWORD}" > /tmp/vpn.login
	
}

connect() {
	ip==(get_ip)
	create_ovpn_files
	
	sudo openvpn \
		--config /tmp/config.ovpn \
		--auth-user-pass /tmp/vpn.login \
		--route $(echo "$ip") 255.255.255.255 net_gateway \
		--route 169.254.0.0 255.255.0.0 net_gateway
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    connect
fi
