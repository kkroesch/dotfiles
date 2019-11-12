# Tools for Git repositories

function clone() {
  # Clone a repository from Github
  git clone https://github.com/$1 
}

function addremotes() {
  # Add two remotes to a local repository (primary and backup)
  REPO_NAME=$(basename `git rev-parse --show-toplevel`)
  git remote add origin git@github.com:kkroesch/${REPO_NAME}.git
  git remote add backup git@nas2.home:${REPO_NAME}.git
}


