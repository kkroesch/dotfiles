set -e # exit on errors

function header {
  echo ""
  echo "$(tput setaf 6)$1$(tput sgr0)"
  echo ""
}

# Shorthand for recurrent commands
alias dj='python manage.py '

function bootstrap() {
	# Setup basic project structure from template
	if [ $1 ] 
	then
		export PROJECT=$1
	else
		export PROJECT=myproject
	fi

	header "Creating project $PROJECT"

	[ -x $(which virtualenv) ] || sudo pip install virtualenv

	virtualenv env
	source env/bin/activate
	pip install --upgrade pip

	header 'Bootstrapping project'

	pip install Django
	django-admin.py startproject --template=https://github.com/pinax/pinax-project-account/zipball/master $PROJECT

	cd $PROJECT
	curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
	chmod +x manage.py

	header 'Installing requirements'

	pip install -r requirements.txt
	./manage.py migrate
	./manage.py loaddata sites

	header 'Done'


	cat <<EOF
	pip install django_suit
	pip install djangorestframework
	pip install markdown
	pip install django-filter
EOF
}

