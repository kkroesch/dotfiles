# Database functions

function create_db() {
	DB=$1

	pass generate -n db/$DB/admin
	pass generate -n db/$DB/app
	pass generate -n db/$DB/report


	mysql -p$(pass db/root) <<EOF
-- Create Database and Users
CREATE DATABASE IF NOT EXISTS $DB;
CREATE USER '${DB}-adm'@'%' IDENTIFIED BY '$(pass db/$DB/admin)';
CREATE USER '${DB}-app'@'%' IDENTIFIED BY '$(pass db/$DB/app)';
CREATE USER '${DB}-rep'@'%' IDENTIFIED BY '$(pass db/$DB/report)';

GRANT ALL PRIVILEGES ON $DB.* TO '${DB}-adm'@'%' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON $DB.* TO '${DB}-app'@'%';
GRANT SELECT ON $DB.* TO '${DB}-rep'@'%';
EOF
}

function drop_db() {
	DB=$1
	mysql -p$(pass db/root) <<EOF
-- Drop Database an Users
DROP USER '${DB}-adm';
DROP USER '${DB}-app';
DROP USER '${DB}-rep';
DROP DATABASE IF EXISTS $DB;
EOF
}
