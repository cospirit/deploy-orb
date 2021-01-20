create_tag() {
    git config --global user.email "${GIT_USER_EMAIL}"
    git config --global user.name "${GIT_USER_NAME}"
    git tag "$1"
    git push --tag origin
}

create_tag "${TAG}"
