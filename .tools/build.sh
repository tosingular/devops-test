#!/usr/bin/env bash

set -eux

import() {
    source $(dirname $0)/$1.sh
}

main() {
    import env

    case $1 in
        linux)
            export CGO_ENABLE=0
            export GOOS=linux
            export GOARCH=amd64
        ;;
    esac

    go mod tidy -v &&
    go build -v -o "${BUILD_DIR}/devops-test" "${PROJECT_ROOT}"
}

main $@
