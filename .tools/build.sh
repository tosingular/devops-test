#!/usr/bin/env bash

set -eux

import() {
    source $(dirname $0)/$1.sh
}

golang_ci() {
    if ! command -v golangci-lint > /dev/null 2>&1; then 
        go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.46.2
    fi
    golangci-lint -v run
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
    golang_ci &&
    go build -v -o "${BUILD_DIR}/devops-test" "${PROJECT_ROOT}"
}

main $@
