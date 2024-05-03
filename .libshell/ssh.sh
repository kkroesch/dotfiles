# SSH Agent Tools

export JUMPHOST=lab.kroesch.net
export SSH_KEY_PATH="~/.ssh/id_ecdsa"
export SESSION_FILE=~/.ssh/session

jump () {
	# Forward agent to jump host
	HOST=$1 
	shift
	ssh -o=LogLevel=ERROR -At $JUMPHOST ssh -At $HOST $@
}

jcp () {
	# Copy file via jump host
	scp -oProxyJump=$JUMPHOST $1 $2 2> /dev/null
}

function sshagent() {
  # Decrypt SSH key and save agent session; add all keys to agent.
  eval `ssh-agent`
  for key in `ls -1 ~/.ssh/id*.pub`
  do 
    ssh-add ${key%.pub}
  done
  echo export SSH_AUTH_SOCK=$SSH_AUTH_SOCK > $SESSION_FILE
  echo export SSH_AGENT_PID=$SSH_AGENT_PID >> $SESSION_FILE
  chmod 600 $SESSION_FILE
}


function ssh-reconnect() {
  # Reconnect agent on new terminal session
  source $SESSION_FILE
}

function ssp() {
  # Login with password instead of public key (requires sshpass and .ssh/password)
  sshpass -f .ssh/password ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no $1
}

function keygen() {
  ssh-keygen -t ed25519 -a 420 -f $1 -C "Example comment"
}

