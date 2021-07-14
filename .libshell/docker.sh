dps() {
  # Show all running containers
  docker ps
}


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

# Run SQL client on dockerized Elasticsearch
alias doesql="docker exec -it elasticsearch /usr/share/elasticsearch/bin/elasticsearch-sql-cli"

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
