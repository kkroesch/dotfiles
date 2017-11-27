function pyinit() {
	mkdir $1 && cd $1
	virtualenv env
	source env/bin/activate
	curl -o .gitignore -L https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
	git init
	pip freeze > requirements.txt
	git add .
}
