git_push() {
    git config --global user.email "${GIT_USER_EMAIL}"
    git config --global user.name "${GIT_USER_NAME}"
    git pull origin "$3"
    git commit -m "$1 [skip ci]" "$2"
    git push origin "$3"
}

git_push "${COMMIT_MSG}" "${COMMIT_FILE}" "${COMMIT_BRANCH:-master}"
