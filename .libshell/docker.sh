
# Communicate via TCP, especially on WSL
# [ -S /var/run/${DOCKER_COMMAND}.sock ] || export ${DOCKER_COMMAND}_HOST=localhost:2375
#

DOCKER_COMMAND=$(which podman)

dps() {
  # Show all running containers
  $DOCKER_COMMAND ps -a
}

dlog() {
  # Show logs for container
  ${DOCKER_COMMAND} logs $1
}

dosh() {
  # Open shell for container
  ${DOCKER_COMMAND} exec -it $1 bash
}

doip() {
  # Show IP address for container
  ${DOCKER_COMMAND} inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}

dipall() {
    # Show all IP addresses in ${DOCKER_COMMAND} Compose project
    for container in $(${DOCKER_COMMAND} ps -q)
    do
      ${DOCKER_COMMAND} inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{.Name}}' $container | tr -d '/'
    done
}

dclean() {
	${DOCKER_COMMAND} container prune
}
