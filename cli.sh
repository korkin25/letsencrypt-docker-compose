#!/bin/bash

usage() {
    cat << EOF
Usage: $(basename "$0") COMMAND

  config  [OPTIONS]          Run the CLI tool
          --no-current-user  Run as root (Docker default) instead of the current user
  
  up      [OPTIONS]          Build, (re)create, and start all services in the background
          --dry-run          Disable Certbot to run all services locally
  
  build   [OPTIONS]          Build or rebuild all Docker images
          --no-cache         Do not use cache when building the images
EOF
    exit 1
}

run_cli() {
    docker-compose run --rm cli
}

run_docker_compose_up() {
    docker-compose up -d
}

run_docker_compose_build() {
    docker-compose --profile config build "${@}"
}

handle_config_command() {
    CMD=run_cli
    CURRENT_USER="$(id -u):$(id -g)"
    DOCKER_GROUP="$(getent group docker | cut -d: -f3)"
    export CURRENT_USER DOCKER_GROUP
    shift

    while [[ $# -gt 0 ]]; do
        case $1 in
            --no-current-user)
                unset CURRENT_USER
                unset DOCKER_GROUP
                shift
                ;;
            *)
                echo "Unknown option $1"
                usage
                ;;
        esac
    done

    "${CMD}"
}

handle_up_command() {
    CMD=run_docker_compose_up
    shift

    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                export DRY_RUN=true
                shift
                ;;
            *)
                echo "Unknown option $1"
                usage
                ;;
        esac
    done

    "${CMD}"
}

handle_build_command() {
    CMD=run_docker_compose_build
    shift

    while [[ $# -gt 0 ]]; do
        case $1 in
            --no-cache)
                shift
                CMD+=(--no-cache)
                ;;
            *)
                echo "Unknown option $1"
                usage
                ;;
        esac
    done

    "${CMD[@]}"
}

main() {
    case $1 in
        config) handle_config_command ;;
        up) handle_up_command ;;
        build) handle_build_command ;;
        *) echo "Unknown command $1"; usage ;;
    esac
}

main "$@"
