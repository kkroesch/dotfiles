
# Communicate via TCP, especially on WSL
[ -S /var/run/docker.sock ] || export DOCKER_HOST=localhost:2375

dps() {
  # Show all running containers
  docker ps -a
}

dlog() {
  # Show logs for container
  docker logs $1
}

dosh() {
  # Open shell for container
  docker exec -it $1 bash
}

dip() {
  # Show IP address for container
  docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}

dipall() {
    # Show all IP addresses in Docker Compose project
    for container in $(docker ps -q)
    do
      docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{.Name}}' $container | tr -d '/'
    done
}

# Ansible toolset as a container on WSL
ansible-tools() {
   docker run --rm -it -v ${PWD//mnt/}:/usr/src/${PWD##*/} quay.io/ansible/toolset
}

# Run SQL client on dockerized Elasticsearch
alias doesql="docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-sql-cli"
alias dc="docker compose"
alias dcu="dc up"
alias dcd="dc down"
alias dcl="dc logs"

docker-rmimages() {
	for image in $(docker images -q)
	do
		docker rmi $image
	done
}

docker-rmmachines() {
	for container in $(docker ps -aq)
	do
		docker rm $container
	done
}

docker-cleanup() {
	dialog --title "Docker Cleanup" \
		--yesno "Are you sure you want to permanently delete Docker machines and images?" 7 60

		# Get exit status
		# 0 means user hit [yes] button.
		# 1 means user hit [no] button.
		# 255 means user hit [Esc] key.
		response=$?
		case $response in
		   0) docker-rmimages && docker-rmmachines;;
		   1) echo "Aborted.";;
		   255) echo "[ESC] key pressed.";;
		esac
		clear
}
