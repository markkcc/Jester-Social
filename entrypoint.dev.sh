#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails/tmp/pids/server.pid

# Install missing gems
bundle install

# Run database migrations
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

# Start the Rails server with the specified binding
export BINDING=${BINDING:-0.0.0.0}

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@" 