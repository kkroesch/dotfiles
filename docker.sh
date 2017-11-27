alias dc="docker-compose"

dosh() {
  # Open shell for container
  docker exec -it $1 bash
}

dip() {
  # Show IP address for container
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

dipall() {
    # Show all IP addresses in Docker Compose project
    for container_name in $(docker-compose ps -q);
    do
        local container_ip=$(dip $container_name)
        if [[ -n "$container_ip" ]]; then
            echo $(dip $container_name) " $container_name"
        fi
    done
}

