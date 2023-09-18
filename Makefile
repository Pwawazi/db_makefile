# Makefile to create PostgreSQL database and user

DB_NAME ?= mydatabase
DB_USER ?= myuser
DB_PASSWORD ?= mypassword
POSTGRES_USER ?= postgres

.PHONY: create_db

create_db:
	# Create the PostgreSQL database
	sudo -u $(POSTGRES_USER) createdb $(DB_NAME)

	# Create the PostgreSQL user with a password and configure role
	sudo -u $(POSTGRES_USER) psql -c "CREATE USER $(DB_USER) WITH PASSWORD '$(DB_PASSWORD)';" 
	sudo -u $(POSTGRES_USER) psql -c "ALTER ROLE $(DB_USER) SET client_encoding TO 'utf8';" 
	sudo -u $(POSTGRES_USER) psql -c "ALTER ROLE $(DB_USER) SET default_transaction_isolation TO 'read committed';" 
	sudo -u $(POSTGRES_USER) psql -c "ALTER ROLE $(DB_USER) SET timezone TO 'UTC';" 

	# Grant privileges to the user on the database
	sudo -u $(POSTGRES_USER) psql -c "GRANT ALL PRIVILEGES ON DATABASE $(DB_NAME) TO $(DB_USER);"
