trim() {
	echo "${1#"${1%%[![:space:]]*}"}"
}

uuid() {
	cat /proc/sys/kernel/random/uuid
}
