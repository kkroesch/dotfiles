# SSH Agent Tools

jump () {
	# Forward agent to jump host
	HOST=$1 
	ssh -At $JUMPHOST ssh -At $HOST
}

jcp () {
	# Copy file via jump host
	scp -oProxyJump=$JUMPHOST $1 $2
}

export SESSION_FILE=~/.ssh/session

function sshagent() {
  # Decrypt SSH key and save agent session
  eval `ssh-agent` && ssh-add .ssh/id_ecdsa
  echo export SSH_AUTH_SOCK=$SSH_AUTH_SOCK > $SESSION_FILE
  echo export SSH_AGENT_PID=$SSH_AGENT_PID >> $SESSION_FILE
  chmod 600 $SESSION_FILE
}

function ssh-reconnect() {
  # Reconnect agent on new terminal session
  source $SESSION_FILE
}
[ -f $SESSION_FILE ] && ssh-reconnect

