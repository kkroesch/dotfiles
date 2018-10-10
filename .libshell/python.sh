
alias mkenv="python3.6 -m venv .venv"
alias activate="source .venv/bin/activate"
alias venv="python3.6 -m venv .venv && source .venv/bin/activate"

function pyinit() {
	PROJECT=${1:-my_project}
	mkdir $PROJECT && cd $PROJECT
	mkenv
	source .venv/bin/activate
	curl -lso .gitignore -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
	git init
	pip install -U pip
	pip freeze > requirements.txt
	git add .
}
