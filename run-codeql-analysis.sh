#!/usr/bin/bash
#
# Call codeql on the codeql-db directory. Call ./create-codeql-db.sh to create it before.
#
# If you wish to have this script overwrite or create the .github/codeql/golden.csv file,
# set the environment variable RECREATE_GOLDEN_FILE to 1.
#
# You can pass a single query as argument to this script. If no argument is specified,
# queries are obtained from .github/codeql/codeql-config.yml (like the CI does).
# Being able to pass a query allows to create the database once with ./create-codeql-db.sh
# and then try different queries with this script afterwards, on the single database created before.
# For example call ./run-codeql-analysis.sh codeql-queries/GetSargeRunSinks.ql to test GetSargeRunSinks.ql

declare -r SARIF_FILE="codeql.sarif"
declare -r CSV_FILE="codeql.csv"
declare -r CODEQL_CONFIG_FILE=".github/codeql/codeql-config.yml"

command -v codeql || { echo "codeql is missing. Please install it."; exit 1; }
command -v sarif || { echo "sarif is missing. Did you install pip install -r dev-requirements.txt?"; exit 1; }

[[ -e "codeql-db" ]] || { echo "codeql-db is missing. Create it with: ./create-codeql-db.sh"; exit 1; }

set -ex

if [[ -z "$1" ]]
then
  # No argument passed. We replicate the CI's behavior that relies
  # on .github/codeql/codeql-config.yml
  command -v yq || { echo "yq is required when the queries to run are omitted. Please install it as follows: https://github.com/mikefarah/yq"; exit 1; }
  queries=() # We use a bash array, to support multiple queries
  # Fill array with lines obtained from yq:
  mapfile -t queries < <(yq '.queries[].uses' "$CODEQL_CONFIG_FILE")
  # Pass queries as separate arguments
  codeql database analyze codeql-db "${queries[@]}" --format=sarif-latest --output="$SARIF_FILE"
else
  codeql database analyze codeql-db "$1" --format=sarif-latest --output="$SARIF_FILE"
fi

rm -Rf "$CSV_FILE"

sarif csv "$SARIF_FILE"

cat "$CSV_FILE"
