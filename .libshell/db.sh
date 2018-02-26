# Database functions

function create_db() {
	DB=$1

	cat <<EOF
-- Create Database and Users
CREATE DATABASE IF NOT EXISTS $DB;
CREATE USER '${DB}-adm'@'%' IDENTIFIED BY '$(openssl rand 8 -hex)';
CREATE USER '${DB}-app'@'%' IDENTIFIED BY '$(openssl rand 8 -hex)';
CREATE USER '${DB}-rep'@'%' IDENTIFIED BY '$(openssl rand 8 -hex)';

GRANT ALL PRIVILEGES ON $DB.* TO '${DB}-adm'@'%' WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON $DB.* TO '${DB}-app'@'%';
GRANT SELECT ON $DB.* TO '${DB}-rep'@'%';
EOF
}

function drop_db() {
	DB=$1
	cat <<EOF
-- Drop Database an Users
DROP USER '${DB}-adm';
DROP USER '${DB}-app';
DROP USER '${DB}-rep';
DROP DATABASE IF EXISTS $DB;
EOF
}