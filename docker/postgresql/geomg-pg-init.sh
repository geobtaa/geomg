#!/bin/bash

# Exit on error, unset vars as error
set -e
set -u

# Inspired by https://github.com/mrts/docker-postgresql-multiple-databases/blob/master/create-multiple-postgresql-databases.sh
# We only need one user
for db in geomg_test geomg_development; do
  # Create each database comma-separated, grant full rights to the pg user
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE DATABASE $db" -c "GRANT ALL PRIVILEGES ON DATABASE $db TO $POSTGRES_USER;"
done
