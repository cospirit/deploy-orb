#!/usr/bin/env bash

# "unofficial" bash strict mode
# See: http://redsymbol.net/articles/unofficial-bash-strict-mode
set -o errexit  # Exit when simple command fails               'set -e'
set -o errtrace # Exit on error inside any functions or subshells.
set -o nounset  # Trigger error when expanding unset variables 'set -u'
set -o pipefail # Do not hide errors within pipes              'set -o pipefail'
#set -o xtrace   # Display expanded command and arguments       'set -x'
IFS=$'\n\t'

ORB_TEST_ENV="bats-core"

if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
	head_line_count=3
else
    head_line_count=10
fi

update_service_version() {
    # sed "s/version:.*$/version: \"${VERSION}\"/" "${SERVICE_CONF_FILE}"
    #sed '0,/version:.*$/ s/version:.*$/version: \"'${VERSION}'\"/' "${SERVICE_CONF_FILE}"
    #awk 'NR==1,/version:.*$/{sub(/version:.*$/, "version: \"'${VERSION}'\"")} 1' "${SERVICE_CONF_FILE}"
    #sed "0,/version:.*$/ s/version:.*$/version: \""${VERSION}"\"/" "${SERVICE_CONF_FILE}"
    #sed "0,/version:.*$/{s/version:.*$/version: \"${VERSION}\"/}" "${SERVICE_CONF_FILE}"
    sed "0,/\(version:\).*$/{s//\1 \"${VERSION}\"/}" "${SERVICE_CONF_FILE}"
    # sed -z -i 's/\(version:\).*/\1 '"${VERSION}"'/M' ${SERVICE_CONF_FILE}
    #sed -i "/\(version:\).*/{s//\1 ${VERSION}/;:a;n;ba}" ${SERVICE_CONF_FILE}

#    sed '/version:.*$/{s//version: \"'${VERSION}'\"/;:p;n;bp}' "${SERVICE_CONF_FILE}" 
#    sed -i '/version:.*$/{s//version: \"'${VERSION}'\"/;q}' "${SERVICE_CONF_FILE}" 
    head -n "$head_line_count" "${SERVICE_CONF_FILE}"
}

# Will not run if sourced for bats-core tests.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    update_service_version
fi
