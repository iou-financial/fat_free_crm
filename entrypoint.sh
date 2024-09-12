#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid
rm -f /var/run/puma.pid

# Configure DATABASE_URL if MYSQL_URL is set
if [ -n "${POSTGRES_URL}" ]; then
  echo "Setting DB_ADAPTER=postgresql"
  export DB_ADAPTER=postgresql
  echo "Configuring DATABASE_URL using POSTGRES_URL"
  export DATABASE_URL="${POSTGRES_URL}"
fi

#echo "loading schema..."
## bundle exec rails db:environment:set RAILS_ENV="${RAILS_ENV}"
## bundle exec rails db:schema:load
##bundle exec rails ffcrm:setup
#echo "Finished running migrations"

echo "Precompile Assets on entrypoint"
SECRET_KEY_BASE=1 bundle exec rake assets:precompile
echo "Finished precompiling assets"

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
