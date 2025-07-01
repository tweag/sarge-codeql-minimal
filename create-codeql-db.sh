#!/usr/bin/bash
#
# Creates the database in the folder codeql-db

command -v codeql || { echo "codeql is missing. Please install it."; exit 1; }

set -eux

DB_FOLDER="codeql-db"

rm codeql-db "$DB_FOLDER" -Rf

codeql database create --language=python "$DB_FOLDER" --source-root=.
