alias cassandrad="docker run --name cassandra -d cassandra:latest"
alias cqlsh='docker run -it --link cassandra:cassandra --rm cassandra sh -c '"'"'exec cqlsh "$CASSANDRA_PORT_9042_TCP_ADDR"'"'"''
