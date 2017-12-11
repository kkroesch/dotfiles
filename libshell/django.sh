
source pretty.sh

function bootstrap() {
	# Setup basic project structure from template
	if [ $1 ] 
	then
		export PROJECT=$1
	else
		export PROJECT=myproject
	fi

	header "Creating project $PROJECT"

	python3 -m venv env
	source env/bin/activate
	pip install --upgrade pip

	header 'Bootstrapping project'

	pip install Django
	django-admin.py startproject \
  		--template=https://github.com/jpadilla/django-project-template/archive/master.zip \
  		--name=Procfile \
  		--extension=py,md,env \
  		$PROJECT

	cd $PROJECT
	mv example.env .env
	curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore
	chmod +x manage.py

	header 'Installing requirements'

	pip install -r requirements.txt
	./manage.py migrate
	./manage.py loaddata sites

	header 'Done'
}

