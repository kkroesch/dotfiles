# SSH Agent Tools

JUMPHOST=hjmpsys01.sharedtcs.net
jumpssh () {
  # Forward agent to jump host
	HOST=$1 
	ssh -At $JUMPHOST ssh -At $HOST
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

function sshfp() {
   # Generate SSHFP DNS record for given hostname
   hostname=$1
   fingerprint=$(ssh-keyscan -t ecdsa $hostname | awk '{ print $3; }' | base64 -d | sha256sum | cut -f 1 -d ' ')
   echo ${hostname}. SSHFP 3 2 $fingerprint
}
