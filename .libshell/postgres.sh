export PGHOST='localhost'
export PGDATABASE='postgres'
export PGUSER='dbadmin'
export PGPORT='5432'

function pwgen() {
    echo -n $(tr -dc 'A-Za-z0-9+!&%?' < /dev/urandom | head -c 16)
}

function pgsuper() {
    # Use for one-time installation of the database beside the postgres system
    # user
    read -r -d '' SQL <<-EOF
	CREATE ROLE dbadmin WITH LOGIN PASSWORD '$(pwgen)';
	GRANT CONNECT ON DATABASE postgres TO dbadmin;
	GRANT USAGE ON SCHEMA pg_catalog TO dbadmin;
	GRANT SELECT ON pg_catalog.pg_database TO dbadmin;
	EOF
    echo $SQL
}

function pgdb() {
    # Create a new database with some reasonable users for hardened access.
    database=$1
    read -r -d '' SQL <<-EOF
	-- Erstelle die Datenbank
	CREATE DATABASE ${database};
	-- Erstelle die Schemas
	CREATE SCHEMA public;
	CREATE SCHEMA archive;
	-- Erstelle den Admin-Benutzer
	CREATE ROLE ${database}_admin WITH LOGIN PASSWORD '$(pwgen)';
	GRANT ALL PRIVILEGES ON DATABASE ${database} TO admin;
	GRANT ALL PRIVILEGES ON SCHEMA public TO ${database}_admin;
	GRANT ALL PRIVILEGES ON SCHEMA archive TO ${database}_admin;
	-- Erstelle den Applikationsbenutzer
	CREATE ROLE ${database}_app WITH LOGIN PASSWORD '$(pwgen)';
	GRANT CONNECT ON DATABASE ${database} TO ${database}_app;
	GRANT USAGE, SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${database}_app;
	GRANT USAGE, SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA archive TO ${database}_app;
	ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO ${database}_app;
	ALTER DEFAULT PRIVILEGES IN SCHEMA archive GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO ${database}_app;
	-- Erstelle den Report-Benutzer
	CREATE ROLE ${database}_report WITH LOGIN PASSWORD '$(pwgen)';
	GRANT CONNECT ON DATABASE ${database} TO ${database}_report;
	GRANT USAGE, SELECT ON ALL TABLES IN SCHEMA public TO ${database}_report;
	GRANT USAGE, SELECT ON ALL TABLES IN SCHEMA archive TO ${database}_report;
	ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO ${database}_report;
	ALTER DEFAULT PRIVILEGES IN SCHEMA archive GRANT SELECT ON TABLES TO ${database}_report;
EOF
echo $SQL

    read -r -d '' SQL <<-EOF
	-- Zugriff auf die Datenbank ifür Superuser gewähren
	GRANT CONNECT ON DATABASE ${database} TO dbadmin;
	-- Zu der spezifischen Datenbank wechseln
	\c ${database}
	-- Zugriff auf das Schema gewähren
	GRANT USAGE ON SCHEMA public TO dbadmin;
	-- Berechtigungen auf alle bestehenden Tabellen im Schema gewähren
	GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO dbadmin;
	-- Standardberechtigungen für zukünftige Tabellen im Schema ändern
	ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO dbadmin;
EOF
echo $SQL
}
