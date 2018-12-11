
alias mkenv="python3.6 -m venv .venv"
alias activate="source .venv/bin/activate"
alias venv="python3.6 -m venv .venv && source .venv/bin/activate"
alias dj="./manage.py"

function pyinit() {
  # Make a Python project from current directory including virtual environment and Git repository
	mkenv
	source .venv/bin/activate
	curl -lso .gitignore -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
	git init
	pip install -U pip
	pip freeze > requirements.txt
	git add .
}
