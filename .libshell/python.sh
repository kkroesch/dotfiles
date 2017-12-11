
alias mkenv="python3.6 -m venv env"
alias activate="source env/bin/activate"

function pyinit() {
	PROJECT=${1:-my_project}
	mkdir $PROJECT && cd $PROJECT
	mkenv
	source env/bin/activate
	curl -lso .gitignore -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
	git init
	pip install -U pip
	pip freeze > requirements.txt
	git add .
}
