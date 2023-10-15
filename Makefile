# Makefile to create PostgreSQL database and user

DB_NAME := $(shell read -p "Enter the database name: " db_name && echo $$db_name)
DB_USER := $(shell read -p "Enter the database user: " db_user && echo $$db_user)
DB_PASSWORD := $(shell read -p "Enter the database password: " db_password && echo $$db_password)
POSTGRES_USER ?= postgres

.PHONY: create_db

create_db:
	# Creating the PostgreSQL database
	@sudo -u $(POSTGRES_USER) createdb $(DB_NAME) 

	# Creating the PostgreSQL user with a password and configure role
	@sudo -u $(POSTGRES_USER) psql -c "CREATE USER $(DB_USER) WITH PASSWORD '$(DB_PASSWORD)';"
	@sudo -u $(POSTGRES_USER) psql -c "ALTER ROLE $(DB_USER) SET client_encoding TO 'utf8';"
	@sudo -u $(POSTGRES_USER) psql -c "ALTER ROLE $(DB_USER) SET default_transaction_isolation TO 'read committed';"
	@sudo -u $(POSTGRES_USER) psql -c "ALTER ROLE $(DB_USER) SET timezone TO 'UTC';"

	# Granting privileges to the user on the database
	@sudo -u $(POSTGRES_USER) psql -c "GRANT ALL PRIVILEGES ON DATABASE $(DB_NAME) TO $(DB_USER);"
	@echo; \
	echo "Created database '$(DB_NAME)' with the user '$(DB_USER)' successfully!"; \
	echo;
